extends CanvasLayer

signal restart_game
signal unpause

var holding_item = null

var hp_3 = [preload("res://Sprites/UI/HP/Max_3/HealthBarFull_3.png"),
			preload("res://Sprites/UI/HP/Max_3/HealthBar_1Damage_3.png"),
			preload("res://Sprites/UI/HP/Max_3/HealthBar_2Damage_3.png"),
			preload("res://Sprites/UI/HP/Max_3/HealthBar_3Damage_3.png")]

var hp_4 = [preload("res://Sprites/UI/HP/Max_4/HealthBarFull_4.png"),
			preload("res://Sprites/UI/HP/Max_4/HealthBar_1Damage_4.png"),
			preload("res://Sprites/UI/HP/Max_4/HealthBar_2Damage_4.png"),
			preload("res://Sprites/UI/HP/Max_4/HealthBar_3Damage_4.png"),
			preload("res://Sprites/UI/HP/Max_4/HealthBar_4Damage_4.png")]

var hp_5 = [preload("res://Sprites/UI/HP/Max_5/HealthBarFull_5.png"),
			preload("res://Sprites/UI/HP/Max_5/HealthBar_1Damage_5.png"),
			preload("res://Sprites/UI/HP/Max_5/HealthBar_2Damage_5.png"),
			preload("res://Sprites/UI/HP/Max_5/HealthBar_3Damage_5.png"),
			preload("res://Sprites/UI/HP/Max_5/HealthBar_4Damage_5.png"),
			preload("res://Sprites/UI/HP/Max_5/HealthBar_5Damage_5.png"),]
onready var hp = $Hit_Points

var weapons = [preload("res://Sprites/UI/blank_sword.png"),
					preload("res://Sprites/UI/blank_bow.png")]

#Open inv
func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
	#	$Inventory.initialize_inventory()
		if (!$Inventory.visible):
			Stats.reset()
			$Inventory.update_stats()

func _on_Unpause_pressed():
	emit_signal("unpause")


func _on_Quit_pressed():
	get_tree().quit()

func update_hp():
	if PlayerStats.max_hit_points == 3:
		if PlayerStats.hit_points == 1:
			hp.texture = hp_3[2]
		elif PlayerStats.hit_points == 2:
			hp.texture = hp_3[1]
		elif PlayerStats.hit_points == 3:
			hp.texture = hp_3[0]
		elif PlayerStats.hit_points == 0:
			hp.texture = hp_3[3]
	elif PlayerStats.max_hit_points == 4:
		if PlayerStats.hit_points == 1:
			hp.texture = hp_4[3]
		elif PlayerStats.hit_points == 2:
			hp.texture = hp_4[2]
		elif PlayerStats.hit_points == 3:
			hp.texture = hp_4[1]
		elif PlayerStats.hit_points == 4:
			hp.texture = hp_4[0]
		elif PlayerStats.hit_points == 0:
			hp.texture = hp_4[4]
	elif PlayerStats.max_hit_points == 5:
		if PlayerStats.hit_points == 1:
			hp.texture = hp_5[4]
		elif PlayerStats.hit_points == 2:
			hp.texture = hp_5[3]
		elif PlayerStats.hit_points == 3:
			hp.texture = hp_5[2]
		elif PlayerStats.hit_points == 4:
			hp.texture = hp_5[1]
		elif PlayerStats.hit_points == 5:
			hp.texture = hp_5[0]
		elif PlayerStats.hit_points == 0:
			hp.texture = hp_5[5]

func update_current_weapon():
	if PlayerStats.weapon_type == 1:
		$Current_Weapon.texture = weapons[0]
	elif PlayerStats.weapon_type == 2:
		$Current_Weapon.texture = weapons[1]
	else:
		$Current_Weapon.texture = weapons[0]

func victory():
	$RestartButton.text = "You Won! Restart?"
	$RestartButton.show()

func _on_RestartButton_pressed():
	emit_signal("restart_game")
