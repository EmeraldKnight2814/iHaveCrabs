extends Node2D

onready var deathSound = $Sounds/death_sound
onready var hitSound = $Sounds/hit_sound
onready var gerald = $Player
onready var pause = $HUD/Pause

func _ready():
	#Initialilze player's stats with base set
	PlayerStats.hit_points = 5
	PlayerStats.max_hit_points = 5
	PlayerStats.damage = 25
	PlayerStats.knockback_modifier = 1
	PlayerStats.weapon_type = 1
	PlayerStats.current_armor = 0
	PlayerStats.current_weapon = 0
	JsonData.main = self
	$HUD.update_hp()
	$HUD.update_boss_hp()
	$HUD.update_current_weapon()

func _unhandled_input(event):
	if(event.is_action_pressed("swap_weapon")):
		if(PlayerStats.weapon_type == 1):
			PlayerStats.weapon_type = 2
			$HUD.update_current_weapon()
		elif(PlayerStats.weapon_type == 2):
			PlayerStats.weapon_type = 1
			$HUD.update_current_weapon()
		else:
			PlayerStats.weapon_type = 1
			$HUD.update_current_weapon()
	if(event.is_action_pressed("pause")):
		get_tree().paused = true
		pause.show()

func _on_Player_hit():
	$HUD.update_hp()
	if gerald.stats.hit_points <= 0:
		deathSound.play()
		$HUD/RestartButton.show()
		$HUD/dead.show()
	else:
		hitSound.play()


func _on_Reginald_King_Of_The_Crabs_King_Crab_Hit():
	$HUD.update_boss_hp()


func _on_Reginald_King_Of_The_Crabs_King_Crab_Killed():
	$HUD.update_boss_hp()
