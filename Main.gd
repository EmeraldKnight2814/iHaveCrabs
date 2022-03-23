extends Node2D

var crab = preload("res://Crab.tscn")
var rng = RandomNumberGenerator.new()

onready var map = $Map
onready var player  = $Player
onready var hitSound = $HitSound
onready var deathSound = $WilhelmScream
onready var enemies = $Enemies

func _on_HUD_start_game():
	map.make_rooms()
	yield(get_tree().create_timer(1.2), "timeout")
	map.make_map()
	yield(get_tree().create_timer(0.2), "timeout")
	for room in $Map/Rooms.get_children():
		if room != map.start_room:
			var numCrabs = rng.randi_range(1, 50)
			for i in numCrabs:
				var c = crab.instance()
				c.position = Vector2(room.position.x + rng.randi_range(-100, 100), room.position.y + rng.randi_range(-100, 100))
				enemies.add_child(c)
	player.position = Vector2(map.start_room.position.x, map.start_room.position.y)


func _on_Player_hit():
	player.LIVES -= 1
	if player.LIVES <= 0:
		deathSound.play()
		print("No Lives Left")
		player.queue_free()
	else:
		hitSound.play()
		print(str(player.LIVES) + " lives left.")
