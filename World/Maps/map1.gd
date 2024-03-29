extends Node2D

var rng = RandomNumberGenerator.new()
var first_room
var rooms_cleared = []

signal healed
signal boss_battle_beginning

onready var room1_collision_shape = $Room1/RoomShape/RectColl
onready var room2_collision_shape = $Room1/RoomShape/RectColl
onready var room3_collision_shape = $Room1/RoomShape/RectColl
onready var room4_collision_shape = $Room1/RoomShape/RectColl
onready var room5_collision_shape = $Room1/RoomShape/RectColl
onready var room6_collision_shape = $Room1/RoomShape/RectColl
onready var room7_collision_shape = $Room1/RoomShape/RectColl
onready var single_room1_collision_shape = $SingleRoom1/RoomShape/RectColl
onready var single_room2_collision_shape = $SingleRoom2/RoomShape/RectColl
onready var single_room3_collision_shape = $SingleRoom3/RoomShape/RectColl
onready var corner_room1_collision_shape = $CornerRoom1/RoomShape/RectColl
onready var corner_room2_collision_shape = $CornerRoom2/RoomShape/RectColl
onready var linear_room_collision_shape = $LinearRoom1/RoomShape/RectColl
onready var boss_room_collision_shape = $BossRoomTop/RoomShape/BossRoomColl

onready var room1_center = $Room1/RoomShape/RectColl.global_position 
onready var room2_center = $Room2/RoomShape/RectColl.global_position 
onready var room3_center = $Room3/RoomShape/RectColl.global_position 
onready var room4_center = $Room4/RoomShape/RectColl.global_position 
onready var room5_center = $Room5/RoomShape/RectColl.global_position 
onready var room6_center = $Room6/RoomShape/RectColl.global_position
onready var room7_center = $Room7/RoomShape/RectColl.global_position 
onready var single_room1_center = $SingleRoom1/RoomShape/RectColl.global_position
onready var single_room2_center = $SingleRoom2/RoomShape/RectColl.global_position 
onready var single_room3_center = $SingleRoom3/RoomShape/RectColl.global_position
onready var corner_room1_center = $CornerRoom1/RoomShape/RectColl.global_position 
onready var corner_room2_center = $CornerRoom2/RoomShape/RectColl.global_position 
onready var linear_room_center = $LinearRoom1/RoomShape/RectColl.global_position 
onready var boss_room_center = $BossRoomTop/RoomShape/BossRoomColl.global_position


signal victory

func start_game():
	rng.randomize()
	first_room = rng.randi_range(1, 4)
	if first_room == 1:
		room3_ready()
	elif first_room == 2:
		room7_ready()
	elif first_room == 3:
		room1_ready()
	elif first_room == 4:
		room2_ready()

func restart():
	get_tree().reload_current_scene()

#FUNCTIONS TO READY ROOMS FOR PLAYERS
func room1_ready():
	$Room1.room_ready()

func room2_ready():
	$Room2.room_ready()

func room3_ready():
	$Room3.room_ready()

func room4_ready():
	$Room4.room_ready()

func room5_ready():
	$Room5.room_ready()

func room6_ready():
	$Room6.room_ready()

func room7_ready():
	$Room7.room_ready()

func corner_room1_ready():
	$CornerRoom1.room_ready()

func corner_room2_ready():
	$CornerRoom2.room_ready()

func single_room1_ready():
	$SingleRoom1.room_ready()

func single_room2_ready():
	$SingleRoom2.room_ready()

func single_room3_ready():
	$SingleRoom3.room_ready()

func linear_room1_ready():
	$LinearRoom1.room_ready()

func boss_room_ready():
	$BossRoomTop.room_ready()




#WHEN ROOMS ARE CLEARED, READY NEW ROOMS
func _on_Room1_room_cleared():
	JsonData.random_drop(room1_center)
	print(room1_center)
	rooms_cleared.append(1)
	room5_ready()
	room4_ready()
	corner_room1_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_Room4_room_cleared():
	JsonData.random_drop(room4_center)
	print(room4_center)
	rooms_cleared.append(4)
	room1_ready()
	room6_ready()
	single_room1_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_Room2_room_cleared():
	JsonData.random_drop(room2_center)
	print(room2_center)
	rooms_cleared.append(2)
	corner_room1_ready()
	corner_room2_ready()
	single_room2_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_CornerRoom1_room_cleared():
	JsonData.random_drop(corner_room1_center)
	print(corner_room1_center)
	rooms_cleared.append(8)
	room1_ready()
	room2_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_SingleRoom1_room_cleared():
	JsonData.random_drop(single_room1_center)
	print(single_room1_center)
	rooms_cleared.append(9)
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_SingleRoom2_room_cleared():
	JsonData.random_drop(single_room2_center)
	print(single_room2_center)
	rooms_cleared.append(10)
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_Room3_room_cleared():
	JsonData.random_drop(room3_center)
	print(room3_center)
	rooms_cleared.append(3)
	single_room3_ready()
	corner_room2_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_CornerRoom2_room_cleared():
	JsonData.random_drop(corner_room2_center)
	print(corner_room2_center)
	rooms_cleared.append(11)
	room3_ready()
	room2_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_LinearRoom1_room_cleared():
	JsonData.random_drop(linear_room_center)
	print(linear_room_center)
	boss_room_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	emit_signal("boss_battle_beginning")
	$RoomClear.play()


func _on_BossRoomTop_room_cleared():
	emit_signal("victory")
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()


func _on_Room5_room_cleared():
	JsonData.random_drop(room5_center)
	print(room5_center)
	rooms_cleared.append(5)
	room7_ready()
	room1_ready()
	room6_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_Room6_room_cleared():
	JsonData.random_drop(room6_center)
	print(room6_center)
	rooms_cleared.append(6)
	room5_ready()
	room4_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_SingleRoom3_room_cleared():
	JsonData.random_drop(single_room3_center)
	print(single_room3_center)
	rooms_cleared.append(12)
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()


func _on_Room7_room_cleared():
	JsonData.random_drop(room7_center)
	print(room7_center)
	rooms_cleared.append(7)
	room5_ready()
	PlayerStats.hit_points = PlayerStats.max_hit_points
	emit_signal("healed")
	$RoomClear.play()
	if rooms_cleared.size() == 12:
		linear_room1_ready()
