extends Node2D



func _on_HUD_start_game():
	$Map.make_rooms()
	yield(get_tree().create_timer(1.2), "timeout")
	$Map.make_map()

