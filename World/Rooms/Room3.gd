extends Node2D

signal room_cleared

var total_crabs = 5
var total_crabs_killed = 0

onready var crab1 = $Enemies/Crab_With_Hat
onready var crab2 = $Enemies/Crab_With_Hat2
onready var crab3 = $Enemies/Crab_With_Hat3
onready var crab4 = $Enemies/Crab_With_Hat4
onready var crab5 = $Enemies/Crab_With_Hat5
var check = false

func _ready():
	crab1.disable_collision_shapes()
	crab2.disable_collision_shapes()
	crab3.disable_collision_shapes()
	crab4.disable_collision_shapes()
	crab5.disable_collision_shapes()
	crab1.hide()
	crab2.hide()
	crab3.hide()
	crab4.hide()
	crab5.hide()

func room_ready():
	if check == false:
		check = true
		$ColorRect.hide()
		$RoomShape/RectColl.set_deferred("disabled", true)
		if total_crabs_killed != total_crabs:
			crab1.reenable_collision_shapes()
			crab2.reenable_collision_shapes()
			crab3.reenable_collision_shapes()
			crab4.reenable_collision_shapes()
			crab5.reenable_collision_shapes()
			crab1.show()
			crab2.show()
			crab3.show()
			crab4.show()
			crab5.show()
	else:
		pass

func _on_Wizard_Crab_Killed():
	total_crabs_killed += 1
	$Crab_Dead.play()
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")
