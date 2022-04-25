extends Node2D

signal room_cleared

var total_crabs = 2
var total_crabs_killed = 0

onready var crab1 = $Enemies/Crab
onready var crab2 = $Enemies/Crab2
var check = false

func _ready():
	crab1.disable_collision_shapes()
	crab2.disable_collision_shapes()
	crab1.hide()
	crab2.hide()

func room_ready():
	if check == false:
		check = true
		$ColorRect.hide()
		$RoomShape/RectColl.set_deferred("disabled", true)
		if total_crabs_killed != total_crabs:
			crab1.reenable_collision_shapes()
			crab2.reenable_collision_shapes()
			crab1.show()
			crab2.show()


func _on_Crab_Killed():
	total_crabs_killed += 1
	$Crab_Dead.play()
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")
