extends Node

export(int) var max_hit_points = 1 setget set_max_hit_points
var hit_points = max_hit_points setget set_hit_points
var damage = damage setget set_damage
var knockback_modifier = knockback_modifier setget set_knockback_modifier
var weapon_type = 1 setget set_weapon_type
var current_weapon = 0
var current_armor = 0
var crab_max_hit_points = 75 setget set_crab_hit_points
var wizard_max_hit_points = 25 setget set_wizard_hit_points
var crab_zone_of_truth_radius = 3000 setget set_crab_zone_of_truth 
var wizard_zone_of_truth_radius = 6000 setget set_wizard_zone_of_truth 
var reginald_hp = 500 setget set_reginald_hit_points
var player

signal no_hit_points
signal hit_points_changed(value)
signal max_hit_points_changed(value)
signal damage_changed(value)
signal knockback_modifier_changed(value)
signal unmatched_changed(value)
signal weapon_type_changed(value)
signal crab_hit_points_changed(value)
signal wizard_hit_points_changed(value)
signal crab_zone_of_truth_changed(value)
signal wizard_zone_of_truth_changed(value)

func set_damage(value):
	damage = value
	emit_signal("damage_changed", damage)

func set_max_hit_points(value):
	max_hit_points = value
	self.hit_points = min(hit_points, max_hit_points)
	emit_signal("max_hit_points_changed", max_hit_points)

func set_hit_points(value):
	hit_points = value
	emit_signal("hit_points_changed", hit_points)
	if hit_points <= 0:
		emit_signal("no_hit_points")

func set_knockback_modifier(value):
	knockback_modifier = value
	emit_signal("knockback_modifier_changed", value)

func set_weapon_type(value):
	weapon_type = value
	emit_signal("weapon_type_changed", value)

func set_crab_hit_points(value):
	crab_max_hit_points = value
	emit_signal("crab_hit_points_changed", value)

func set_wizard_hit_points(value):
	wizard_max_hit_points = value
	emit_signal("wizard_hit_points_changed", value)

func set_crab_zone_of_truth(value):
	crab_zone_of_truth_radius = value
	emit_signal("crab_zone_of_truth_changed", value)

func set_wizard_zone_of_truth(value):
	wizard_zone_of_truth_radius = value
	emit_signal("wizard_zone_of_truth_changed", value)

func set_reginald_hit_points(value):
	reginald_hp = value

func _ready():
	self.hit_points = max_hit_points

func set_stats(item_name):
	if (JsonData.item_data[item_name]["Mspeed"] != null):
		get_tree().call_group("enemy", "up_speed", JsonData.item_data[item_name]["Mspeed"])
		print("C Speed Change")
	
	if (JsonData.item_data[item_name]["Fspeed"] != null):
		get_tree().call_group("enemy", "fire_speed", JsonData.item_data[item_name]["Fspeed"])
		print("F Speed Change")
	
	if (JsonData.item_data[item_name]["Mhealth"] != null):
		get_tree().call_group("enemy", "up_health", JsonData.item_data[item_name]["Mhealth"])
		print("C Health Change")
	
	if (JsonData.item_data[item_name]["Pweapon"] != null):
		current_weapon = JsonData.item_data[item_name]["Pweapon"]
		player.updateSprite()
		print("P Weapon Change")
	
	if (JsonData.item_data[item_name]["Parmor"] != null):
		current_armor = JsonData.item_data[item_name]["Parmor"]
		player.updateSprite()
		print("P Armor Change")
func reset():
	get_tree().call_group("enemy", "reset")
