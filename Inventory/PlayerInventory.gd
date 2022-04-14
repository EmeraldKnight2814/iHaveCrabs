extends Node
const SlotClass = preload("res://Inventory/Slot.gd")
const ItemClass = preload("res://Inventory/Item.gd")
const NUM_INVENTORY_SLOTS = 32

var inventory = {
	0: ["PCard"]
}

func add_item(item_name):
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name]
			update_slot_visual(i, inventory[i][0])
			return

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name]

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)

func update_slot_visual(slot_index, item_name):
	var slot = get_tree().root.get_node("/root/Main/HUD/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name)
	else:
		slot.initialize_item(item_name)
