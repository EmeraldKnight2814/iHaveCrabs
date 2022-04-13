extends Node

const NUM_INVENTORY_SLOTS = 32

var inventory = {
	0: ["PCard"]
}

func add_item(item_name):
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name]
			return
