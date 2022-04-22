extends Node2D

signal room_cleared

var total_crabs = 2
var total_crabs_killed = 0

onready var crab1 = $Enemies/Crab
onready var crab2 = $Enemies/Crab2

func _ready():
	crab1.disable_collision_shapes()
	crab2.disable_collision_shapes()
	crab1.hide()
	crab2.hide()

func room_ready():
	$ColorRect.hide()
	$RoomShape/RectColl.disabled = true
	crab1.reenable_collision_shapes()
	crab2.reenable_collision_shapes()
	crab1.show()
	crab2.show()


func _on_Crab_Killed():
	total_crabs_killed += 1
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")
