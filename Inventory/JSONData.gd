extends Node

var item_data: Dictionary
var drop = preload("res://Inventory/ItemDrop.tscn")
var check = true
var main

func _ready():
	randomize()
	item_data = LoadData("res://Data/ItemData.json")

func LoadData(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result

func random_drop(position: Vector2):
	item_data = LoadData("res://Data/ItemData.json")
	var item_drop = drop.instance()
	item_drop.item_name = get_name()
	item_drop.global_position = position
	main.add_child(item_drop)
	print("Tried!")
	print("Item drop position = " + str(position))

func get_name():
	var a = item_data.keys()
	a = a[randi() % a.size()]
	return a
