extends Node

var item_data: Dictionary
var drop = preload("res://Inventory/ItemDrop.tscn")
var check = true
var main

func _ready():
	item_data = LoadData("res://Data/ItemData.json")

func LoadData(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result

func random_drop(crab_position: Vector2):
	item_data = LoadData("res://Data/ItemData.json")
	var item_drop = drop.instance()
	item_drop.position = crab_position
	item_drop.item_name = get_name()
	main.add_child(drop.instance())
	print("Tried!")

func get_name():
	var a = item_data.keys()
	a = a[randi() % a.size()]
	return a
