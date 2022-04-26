extends Node2D

signal room_cleared

onready var reginald = $Boss/Reginald_King_Of_The_Crabs

func _ready():
	reginald.disable_collision_shapes()
	reginald.hide()

func room_ready():
	$ColorRect.hide()
	$RoomShape/BossRoomColl.set_deferred("disabled", true)
	reginald.reenable_collision_shapes()
	reginald.show()


func _on_Reginald_King_Of_The_Crabs_Killed():
	$Crab_Dead.play()
	emit_signal("room_cleared")
