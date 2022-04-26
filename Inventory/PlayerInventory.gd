extends Node
const SlotClass = preload("res://Inventory/Slot.gd")
const ItemClass = preload("res://Inventory/Item.gd")
const NUM_INVENTORY_SLOTS = 32

var inventory = {
	0: ["Card_A"],
	1: ["Card_A"],
	2: ["Card_A"],
	3: ["Card_A"],
	4: ["Card_Z"],
	5: ["Card_A"],
	6: ["Card_Z"]
}

var equips = {

	}

func add_item(item_name):
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name]
			update_slot_visual(i, inventory[i][0])
			return

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	match slot.SlotType:
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index] = [item.item_name]
		_:
			equips[slot.slot_index] = [item.item_name]

func remove_item(slot: SlotClass):
	match slot.SlotType:
		SlotClass.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
		_:
			equips.erase(slot.slot_index)

func update_slot_visual(slot_index, item_name):
	var slot = get_tree().root.get_node("/root/Main/HUD/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name)
	else:
		slot.initialize_item(item_name)
