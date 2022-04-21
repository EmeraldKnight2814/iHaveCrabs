extends Node2D

signal room_cleared

var total_crabs
var total_crabs_killed = 0

func _ready():
	pass

func room_ready():
	$ColorRect.hide()
	$RoomShape/RectColl.disabled = true
