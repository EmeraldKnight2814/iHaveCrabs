extends Node2D

signal room_cleared

onready var crab = $Enemies/Crab
var check = false

func _ready():
	crab.disable_collision_shapes()
	crab.hide()

func room_ready():
	if check == false:
		check = true
		$ColorRect.hide()
		$RoomShape/RectColl.set_deferred("disabled", true)
		crab.reenable_collision_shapes()
		crab.show()


func _on_Crab_Killed():
	emit_signal("room_cleared")
