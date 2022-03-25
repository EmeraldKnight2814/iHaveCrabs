extends Node

export(int) var max_hit_points = 1 setget set_max_hit_points
var hit_points = max_hit_points setget set_hit_points
var damage = damage setget set_damage

signal no_hit_points
signal hit_points_changed(value)
signal max_hit_points_changed(value)
signal damage_changed(value)

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

func _ready():
	self.hit_points = max_hit_points
