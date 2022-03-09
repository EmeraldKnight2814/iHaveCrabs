extends Node2D



func _on_HUD_start_game():
	$Map.make_rooms()
	yield(get_tree().create_timer(1.2), "timeout")
	$Map.make_map()
	yield(get_tree().create_timer(0.2), "timeout")
	$Player.position = Vector2($Map.start_room.position.x, $Map.start_room.position.y)

