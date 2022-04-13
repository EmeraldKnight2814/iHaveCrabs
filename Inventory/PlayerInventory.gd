extends Node

const NUM_INVENTORY_SLOTS = 20

var inventory = {
	0: ["PCard", 1]
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			#TODO check if slot is full
			
