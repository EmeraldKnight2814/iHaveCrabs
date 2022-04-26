extends Node2D

func _ready():
	#Initialilze player's stats with base set
	PlayerStats.hit_points = 100
	PlayerStats.max_hit_points = 100
	PlayerStats.damage = 25
	PlayerStats.knockback_modifier = 1
	PlayerStats.weapon_type = 1
	PlayerStats.current_armor = 0
	PlayerStats.current_weapon = 0
	JsonData.main = self
