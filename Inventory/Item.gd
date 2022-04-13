extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val =  randi() % 3
	if rand_val == 0:
		item_name = "MCard"
	elif rand_val == 1:
		item_name = "BCard"
	else:
		item_name = "PCard"
	
	$TextureRect.texture = load("res://Cards/Templates/" + item_name + ".png")

func set_item(nm):
	item_name = nm
	$TextureRect.texture = load("res://Cards/Templates/" + item_name + ".png")
