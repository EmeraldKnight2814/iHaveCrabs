extends Node2D

var crab = preload("res://Enemies/Crab.tscn")
var rng = RandomNumberGenerator.new()

onready var gerald  = $Gerald
onready var hitSound = $HitSound
onready var deathSound = $WilhelmScream
onready var enemies = $Enemies
onready var geraldStats = PlayerStats
onready var bgm = $BGM #found at https://www.youtube.com/watch?v=arN6WFqCjgw
onready var hud = $HUD
onready var pause = $HUD/Pause

func _ready():
	#Initialilze player's stats with base set
	geraldStats.hit_points = 3
	geraldStats.damage = 25
	geraldStats.knockback_modifier = 1
	geraldStats.weapon_type = 1
	geraldStats.current_armor = 0
	geraldStats.current_weapon = 0

func _on_HUD_start_game():
	pass

func _unhandled_input(event):
	if(event.is_action_pressed("swap_weapon")):
		if(geraldStats.weapon_type == 1):
			geraldStats.weapon_type = 2
		elif(geraldStats.weapon_type == 2):
			geraldStats.weapon_type = 1
		else:
			geraldStats.weapon_type = 1
	if(event.is_action_pressed("pause")):
		get_tree().paused = true
		pause.show()

func _on_Player_hit():
	if gerald.stats.hit_points <= 0:
		deathSound.play()
		print("No Lives Left")
	else:
		hitSound.play()
		print(str(gerald.stats.hit_points) + " lives left.")


func _on_HUD_unpause():
	pause.hide()
	get_tree().paused = false
