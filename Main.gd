extends Node2D

var crab = preload("res://Crab.tscn")
var rng = RandomNumberGenerator.new()

onready var player  = $Player
onready var hitSound = $HitSound
onready var deathSound = $WilhelmScream
onready var enemies = $Enemies

func _on_HUD_start_game():
	pass


func _on_Player_hit():
	player.LIVES -= 1
	if player.LIVES <= 0:
		deathSound.play()
		print("No Lives Left")
		player.queue_free()
	else:
		hitSound.play()
		print(str(player.LIVES) + " lives left.")
