extends Node2D

signal room_cleared

onready var crab = $Enemies/Crab

func _ready():
	crab.disable_collision_shapes()
	crab.hide()

func room_ready():
	$ColorRect.hide()
	$RoomShape/RectColl.call_deferred("free")
	crab.reenable_collision_shapes()
	crab.show()


func _on_Crab_Killed():
	emit_signal("room_cleared")
