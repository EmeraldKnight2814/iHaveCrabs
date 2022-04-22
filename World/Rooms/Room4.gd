extends Node2D

signal room_cleared

var total_crabs = 7
var total_crabs_killed = 0

onready var crab1 = $Enemies/Crab
onready var crab2 = $Enemies/Crab2
onready var crab3 = $Enemies/Crab3
onready var crab4 = $Enemies/Crab4
onready var crab5 = $Enemies/Crab5
onready var crab6 = $Enemies/Crab_With_Hat
onready var crab7 = $Enemies/Crab_With_Hat2

func _ready():
	crab1.disable_collision_shapes()
	crab2.disable_collision_shapes()
	crab3.disable_collision_shapes()
	crab4.disable_collision_shapes()
	crab5.disable_collision_shapes()
	crab6.disable_collision_shapes()
	crab7.disable_collision_shapes()
	crab1.hide()
	crab2.hide()
	crab3.hide()
	crab4.hide()
	crab5.hide()
	crab6.hide()
	crab7.hide()

func room_ready():
	$ColorRect.hide()
	$RoomShape/RectColl.disabled = true
	crab1.reenable_collision_shapes()
	crab2.reenable_collision_shapes()
	crab3.reenable_collision_shapes()
	crab4.reenable_collision_shapes()
	crab5.reenable_collision_shapes()
	crab6.reenable_collision_shapes()
	crab7.reenable_collision_shapes()
	crab1.show()
	crab2.show()
	crab3.show()
	crab4.show()
	crab5.show()
	crab6.show()
	crab7.show()


func _on_Crab_Killed():
	total_crabs_killed += 1
	$Crab_Dead.play()
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")


func _on_Wizard_Crab_Killed():
	total_crabs_killed += 1
	$Crab_Dead.play()
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")
