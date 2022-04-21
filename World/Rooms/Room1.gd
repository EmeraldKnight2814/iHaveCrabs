extends Node2D

var total_crabs = 10
var total_crabs_killed = 0

signal room_cleared


func _on_Crab_Crab_Killed():
	total_crabs_killed += 1
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")


func _on_Wizard_Crab_Killed():
	total_crabs_killed += 1
	if total_crabs_killed == total_crabs:
		emit_signal("room_cleared")
