extends Node2D

var Room = preload("res://Room.tscn")
onready var Map = $TileMap

var tile_size = 16 #Size of a tile in the TileMap
var num_rooms = 50 #Number of rooms to generate
var min_size = 8 #Minimum size of room in TILES
var max_size = 20 #Maximum size of room in TILES
var hspread = 400 #Horizontal spread in PIXELS
var cull = 0.5 #Chance to cull room

var path #AStar pathfinding object
var start_room = null
var end_room = null


func _ready():
	randomize()
	
func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-hspread, hspread), 0)
		var r = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)
	#wait for movement to stop
	yield(get_tree().create_timer(1.1), "timeout")
	#cull rooms
	var room_positions = []
	for room in $Rooms.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.mode = RigidBody2D.MODE_STATIC
			room_positions.append(Vector3(room.position.x, room.position.y, 0))
	
	yield(get_tree(), "idle_frame")
	# Generate a minimum spanning tree connecting the rooms
	path = find_mst(room_positions)
"""
func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2), Color(0, 255, 0), false)
	if path:
		for p in path.get_points():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y), Color(1, 1, 0), 15, true)
"""

func _process(delta):
	update()
	
"""
Inputs for testing

func _input(event):
	if event.is_action_pressed('ui_select'):
		for n in $Rooms.get_children():
			n.queue_free()
		Map.clear()
		path = null
		start_room = null
		end_room = null
		make_rooms()
	if event.is_action_pressed("ui_focus_next"):
		make_map()
"""

func find_mst(nodes):
	#Prims Algorithm (https://en.wikipedia.org/wiki/Prim%27s_algorithm)
	var path = AStar.new()
	path.add_point(path.get_available_point_id(), nodes.pop_front())
	
	#repeat until no more nodes remain
	while nodes:
		var min_dist = INF #Minimum distance so far
		var min_p = null #Position of that node
		var p = null #Current position
		#loop through points in path
		for p1 in path.get_points():
			p1 = path.get_point_position(p1)
			#loop through remaining nodes
			for p2 in nodes:
				if p1.distance_to(p2) < min_dist:
					min_dist = p1.distance_to(p2)
					min_p = p2
					p = p1
		var n = path.get_available_point_id()
		path.add_point(n, min_p)
		path.connect_points(path.get_closest_point(p), n)
		nodes.erase(min_p)
	return path 
		
func make_map():
	# Create a TileMap from the generated rooms and path
	#Map.clear()
	find_start_room()
	find_end_room()
	
	# Fill TileMap with walls, then carve empty rooms
	var full_rect = Rect2()
	for room in $Rooms.get_children():
		var r = Rect2(room.position-room.size,
					room.get_node("CollisionShape2D").shape.extents*2)
		full_rect = full_rect.merge(r)
	var topleft = Map.world_to_map(full_rect.position)
	var bottomright = Map.world_to_map(full_rect.end)
	for x in range(topleft.x, bottomright.x):
		for y in range(topleft.y, bottomright.y):
			Map.set_cell(x, y, 1)	
	
	# Carve rooms
	var corridors = []  # One corridor per connection
	for room in $Rooms.get_children():
		var s = (room.size / tile_size).floor()
		var pos = Map.world_to_map(room.position)
		var ul = (room.position / tile_size).floor() - s
		for x in range(2, s.x * 2 - 1):
			for y in range(2, s.y * 2 - 1):
				Map.set_cell(ul.x + x, ul.y + y, 0)
		# Carve connecting corridor
		var p = path.get_closest_point(Vector3(room.position.x, 
											room.position.y, 0))
		for conn in path.get_point_connections(p):
			if not conn in corridors:
				var start = Map.world_to_map(Vector2(path.get_point_position(p).x,
													path.get_point_position(p).y))
				var end = Map.world_to_map(Vector2(path.get_point_position(conn).x,
													path.get_point_position(conn).y))									
				carve_path(start, end)
		corridors.append(p)
				
func carve_path(pos1, pos2):
	# Carve a path between two points
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0: x_diff = pow(-1.0, randi() % 2)
	if y_diff == 0: y_diff = pow(-1.0, randi() % 2)
	# choose either x/y or y/x
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		Map.set_cell(x, x_y.y, 0)
		Map.set_cell(x, x_y.y + y_diff, 0)  # widen the corridor
	for y in range(pos1.y, pos2.y, y_diff):
		Map.set_cell(y_x.x, y, 0)
		Map.set_cell(y_x.x + x_diff, y, 0)
	
func find_start_room():
	var min_x = INF
	for room in $Rooms.get_children():
		if room.position.x < min_x:
			start_room = room
			min_x = room.position.x

func find_end_room():
	var max_x = -INF
	for room in $Rooms.get_children():
		if room.position.x > max_x:
			end_room = room
			max_x = room.position.x
