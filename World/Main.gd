extends Node2D

var crab = preload("res://Enemies/Crab.tscn")
var rng = RandomNumberGenerator.new()

onready var gerald  = $Gerald
onready var hitSound = $HitSound
onready var deathSound = $WilhelmScream
onready var enemies = $Enemies
onready var geraldStats = PlayerStats

func _ready():
	geraldStats.hit_points = 3
	geraldStats.damage = 25

func _on_HUD_start_game():
	pass


func _on_Player_hit():
	if gerald.stats.hit_points <= 0:
		deathSound.play()
		print("No Lives Left")
	else:
		hitSound.play()
		print(str(gerald.stats.hit_points) + " lives left.")
