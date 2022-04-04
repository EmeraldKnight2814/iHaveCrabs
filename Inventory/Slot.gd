extends Panel

var ItemClass = preload("res://Inventory/Item.tscn")
var item = null

func _ready():
	if randi() % 2 == 0:
		item = ItemClass.instance()
		add_child(item)
