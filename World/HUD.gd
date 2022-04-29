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

var boss_hp_bar = [preload("res://Sprites/UI/HP/Boss/Full.png"),
					preload("res://Sprites/UI/HP/Boss/475_HP.png"),
					preload("res://Sprites/UI/HP/Boss/450_HP.png"),
					preload("res://Sprites/UI/HP/Boss/425_HP.png"),
					preload("res://Sprites/UI/HP/Boss/400_HP.png"),
					preload("res://Sprites/UI/HP/Boss/375_HP.png"),
					preload("res://Sprites/UI/HP/Boss/350_HP.png"),
					preload("res://Sprites/UI/HP/Boss/325_HP.png"),
					preload("res://Sprites/UI/HP/Boss/300_HP.png"),
					preload("res://Sprites/UI/HP/Boss/275_HP.png"),
					preload("res://Sprites/UI/HP/Boss/250_HP.png"),
					preload("res://Sprites/UI/HP/Boss/225_HP.png"),
					preload("res://Sprites/UI/HP/Boss/200_HP.png"),
					preload("res://Sprites/UI/HP/Boss/175_HP.png"),
					preload("res://Sprites/UI/HP/Boss/150_HP.png"),
					preload("res://Sprites/UI/HP/Boss/125_HP.png"),
					preload("res://Sprites/UI/HP/Boss/100_HP.png"),
					preload("res://Sprites/UI/HP/Boss/075_HP.png"),
					preload("res://Sprites/UI/HP/Boss/050_HP.png"),
					preload("res://Sprites/UI/HP/Boss/025_HP.png"),
					preload("res://Sprites/UI/HP/Boss/000_HP.png"),]

onready var boss_hp = $BossBar/Bar
onready var boss_name = $BossBar/Name

var weapons = [preload("res://Sprites/UI/blank_sword.png"),
					preload("res://Sprites/UI/blank_bow.png")]


#Open inv
func _input(event):
	if event.is_action_pressed("inventory"):
		get_tree().paused = true
		$Inventory.visible = !$Inventory.visible
	#	$Inventory.initialize_inventory()
		if (!$Inventory.visible):
			Stats.reset()
			$Inventory.update_stats()
			change_stats()
			get_tree().paused = false

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

func update_boss_hp():
	if Stats.reginald_hp == 500:
		boss_hp.texture = boss_hp_bar[0]
	elif Stats.reginald_hp == 475:
		boss_hp.texture = boss_hp_bar[1]
	elif Stats.reginald_hp == 450:
		boss_hp.texture = boss_hp_bar[2]
	elif Stats.reginald_hp == 425:
		boss_hp.texture = boss_hp_bar[3]
	elif Stats.reginald_hp == 400:
		boss_hp.texture = boss_hp_bar[4]
	elif Stats.reginald_hp == 375:
		boss_hp.texture = boss_hp_bar[5]
	elif Stats.reginald_hp == 350:
		boss_hp.texture = boss_hp_bar[6]
	elif Stats.reginald_hp == 325:
		boss_hp.texture = boss_hp_bar[7]
	elif Stats.reginald_hp == 300:
		boss_hp.texture = boss_hp_bar[8]
	elif Stats.reginald_hp == 275:
		boss_hp.texture = boss_hp_bar[9]
	elif Stats.reginald_hp == 250:
		boss_hp.texture = boss_hp_bar[10]
	elif Stats.reginald_hp == 225:
		boss_hp.texture = boss_hp_bar[11]
	elif Stats.reginald_hp == 200:
		boss_hp.texture = boss_hp_bar[12]
	elif Stats.reginald_hp == 175:
		boss_hp.texture = boss_hp_bar[13]
	elif Stats.reginald_hp == 150:
		boss_hp.texture = boss_hp_bar[14]
	elif Stats.reginald_hp == 125:
		boss_hp.texture = boss_hp_bar[15]
	elif Stats.reginald_hp == 100:
		boss_hp.texture = boss_hp_bar[16]
	elif Stats.reginald_hp == 075:
		boss_hp.texture = boss_hp_bar[17]
	elif Stats.reginald_hp == 050:
		boss_hp.texture = boss_hp_bar[18]
	elif Stats.reginald_hp == 025:
		boss_hp.texture = boss_hp_bar[19]
	elif Stats.reginald_hp == 000:
		boss_hp.texture = boss_hp_bar[20]

func update_current_weapon():
	if PlayerStats.weapon_type == 1:
		$Current_Weapon.texture = weapons[0]
	elif PlayerStats.weapon_type == 2:
		$Current_Weapon.texture = weapons[1]
	else:
		$Current_Weapon.texture = weapons[0]

func change_stats():
	$StatBar/Damage.set_text("Damage: " + str(PlayerStats.damage))
	$StatBar/Speed.set_text("Speed: " + str(PlayerStats.speed))
	$StatBar/Acc.set_text("Accelerate: " + str(PlayerStats.acc))
	$StatBar/Cdamage.set_text("Damage: " + str(PlayerStats.damage))
	$StatBar/Cspeed.set_text("Speed: " + str(PlayerStats.speed))
	$StatBar/CAcc.set_text("Accelerate: " + str(PlayerStats.acc))
	$StatBar/Cfrate.set_text("Fire Rate: " + str(PlayerStats.damage))
	$StatBar/Chealth.set_text("Health: " + str(PlayerStats.speed))

func victory():
	$RestartButton.text = "You Won! Restart?"
	$RestartButton.show()

func _on_RestartButton_pressed():
	emit_signal("restart_game")
