extends Node2D

signal room_cleared

var total_crabs = 20
var total_crabs_killed = 0

onready var crab1 = $Enemies/Crab
onready var crab2 = $Enemies/Crab2
onready var crab3 = $Enemies/Crab3
onready var crab4 = $Enemies/Crab4
onready var crab5 = $Enemies/Crab5
onready var crab6 = $Enemies/Crab6
onready var crab7 = $Enemies/Crab7
onready var crab8 = $Enemies/Crab8
onready var crab9 = $Enemies/Crab9
onready var crab10 = $Enemies/Crab10
onready var crab11 = $Enemies/Crab11
onready var crab12 = $Enemies/Crab12
onready var crab13 = $Enemies/Crab13
onready var crab14 = $Enemies/Crab14
onready var crab15 = $Enemies/Crab15
onready var crab16 = $Enemies/Crab16
onready var crab17 = $Enemies/Crab17
onready var crab18 = $Enemies/Crab18
onready var crab19 = $Enemies/Crab19
onready var crab20 = $Enemies/Crab20
var check = false

func _ready():
	crab1.disable_collision_shapes()
	crab2.disable_collision_shapes()
	crab3.disable_collision_shapes()
	crab4.disable_collision_shapes()
	crab5.disable_collision_shapes()
	crab6.disable_collision_shapes()
	crab7.disable_collision_shapes()
	crab8.disable_collision_shapes()
	crab9.disable_collision_shapes()
	crab10.disable_collision_shapes()
	crab11.disable_collision_shapes()
	crab12.disable_collision_shapes()
	crab13.disable_collision_shapes()
	crab14.disable_collision_shapes()
	crab15.disable_collision_shapes()
	crab16.disable_collision_shapes()
	crab17.disable_collision_shapes()
	crab18.disable_collision_shapes()
	crab19.disable_collision_shapes()
	crab20.disable_collision_shapes()
	crab1.hide()
	crab2.hide()
	crab3.hide()
	crab4.hide()
	crab5.hide()
	crab6.hide()
	crab7.hide()
	crab8.hide()
	crab9.hide()
	crab10.hide()
	crab11.hide()
	crab12.hide()
	crab13.hide()
	crab14.hide()
	crab15.hide()
	crab16.hide()
	crab17.hide()
	crab18.hide()
	crab19.hide()
	crab20.hide()

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
			crab6.reenable_collision_shapes()
			crab7.reenable_collision_shapes()
			crab8.reenable_collision_shapes()
			crab9.reenable_collision_shapes()
			crab10.reenable_collision_shapes()
			crab11.reenable_collision_shapes()
			crab12.reenable_collision_shapes()
			crab13.reenable_collision_shapes()
			crab14.reenable_collision_shapes()
			crab15.reenable_collision_shapes()
			crab16.reenable_collision_shapes()
			crab17.reenable_collision_shapes()
			crab18.reenable_collision_shapes()
			crab19.reenable_collision_shapes()
			crab20.reenable_collision_shapes()
			crab1.show()
			crab2.show()
			crab3.show()
			crab4.show()
			crab5.show()
			crab6.show()
			crab7.show()
			crab8.show()
			crab9.show()
			crab10.show()
			crab11.show()
			crab12.show()
			crab13.show()
			crab14.show()
			crab15.show()
			crab16.show()
			crab17.show()
			crab18.show()
			crab19.show()
			crab20.show()


func _on_Crab_Killed():
	$Crab_Dead.play()
	total_crabs_killed += 1
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")
