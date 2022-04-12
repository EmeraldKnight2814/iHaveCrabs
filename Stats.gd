extends Node

export(int) var max_hit_points = 1 setget set_max_hit_points
var hit_points = max_hit_points setget set_hit_points
var damage = damage setget set_damage
var knockback_modifier = knockback_modifier setget set_knockback_modifier
var weapon_type = 1 setget set_weapon_type
var current_weapon = 0 setget set_current_weapon
var current_armor = 0 setget set_current_armor

signal no_hit_points
signal hit_points_changed(value)
signal max_hit_points_changed(value)
signal damage_changed(value)
signal knockback_modifier_changed(value)
signal unmatched_changed(value)
signal weapon_type_changed(value)
signal current_weapon_changed(value)
signal current_armor_changed(value)

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

func set_current_weapon(value):
	current_weapon = value
	emit_signal("current_weapon_changed", value)
	
func set_current_armor(value):
	current_armor = value
	emit_signal("current_armor_changed", value)

func _ready():
	self.hit_points = max_hit_points
