extends Node2D

var crab = preload("res://Crab.tscn")
var rng = RandomNumberGenerator.new()

func _on_HUD_start_game():
	$Map.make_rooms()
	yield(get_tree().create_timer(1.2), "timeout")
	$Map.make_map()
	yield(get_tree().create_timer(0.2), "timeout")
	for room in $Map/Rooms.get_children():
		if room != $Map.start_room:
			var numCrabs = rng.randi_range(1, 300)
			for i in numCrabs:
				var c = crab.instance()
				c.position = Vector2(room.position.x + rng.randi_range(-100, 100), room.position.y + rng.randi_range(-100, 100))
				$Enemies.add_child(c)
	$Player.position = Vector2($Map.start_room.position.x, $Map.start_room.position.y)
"""
func _input(event):
	if event.is_action_pressed("reset_map_test"):
		$Map.make_rooms()
		yield(get_tree().create_timer(1.2), "timeout")
		$Map.make_map()
		yield(get_tree().create_timer(0.2), "timeout")
		$Player.position = Vector2($Map.start_room.position.x, $Map.start_room.position.y)
"""
