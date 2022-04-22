extends Node2D

signal room_cleared

onready var reginald = $Boss/Reginald_king_of_the_crabs

func _ready():
	reginald.disable_collision_shapes()
	reginald.hide()

func room_ready():
	$ColorRect.hide()
	$RoomShape/RectColl.disabled = true
	reginald.reenable_collision_shapes()
	reginald.show()


func _on_Reginald_king_of_the_crabs_Killed():
	emit_signal("room_cleared")
