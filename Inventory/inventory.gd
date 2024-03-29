extends Node2D

const SlotClass = preload("res://Inventory/Slot.gd")
onready var inventory_slots = $GridContainer
onready var equip_slots = $EquipSlots.get_children()

func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
	
	for i in range(equip_slots.size()):
		equip_slots[i].connect("gui_input", self, "slot_gui_input", [equip_slots[i]])
		equip_slots[i].slot_index = i
	equip_slots[0].slotType = SlotClass.SlotType.P
	equip_slots[1].slotType = SlotClass.SlotType.P
	equip_slots[2].slotType = SlotClass.SlotType.P
	equip_slots[3].slotType = SlotClass.SlotType.X
	initialize_inventory()
	initialize_equips() 

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0])

func initialize_equips():
	for i in range(equip_slots.size()):
		if PlayerInventory.equips.has(i):
			equip_slots[i].initialize_item(PlayerInventory.equips[i][0])
			Stats.set_stats(PlayerInventory.equips[i][0])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if find_parent("HUD").holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
				else:
					left_click_swap(event, slot)
			elif slot.item:
				left_click_not_holding(slot)

func _input(event):
	if find_parent("HUD").holding_item:
		find_parent("HUD").holding_item.global_position = get_global_mouse_position()

func able_to_put_into_slot(slot: SlotClass):
	var holding_item = find_parent("HUD").holding_item
	if holding_item == null:
		return true
	var holding_item_category = JsonData.item_data[holding_item.item_name]["Type"]
	
	if slot.slotType == SlotClass.SlotType.P:
		return holding_item_category == "P"
	elif slot.slotType == SlotClass.SlotType.X:
		return holding_item_category == "X"
	return true

func left_click_empty_slot(slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.add_item_to_empty_slot(find_parent("HUD").holding_item, slot)
		slot.putIntoSlot(find_parent("HUD").holding_item)
		find_parent("HUD").holding_item = null

func left_click_swap(event: InputEvent, slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_to_empty_slot(find_parent("HUD").holding_item, slot)
		var temp_item = slot.item
		slot.pickFromSlot()
		temp_item.global_position = event.global_position
		slot.putIntoSlot(find_parent("HUD").holding_item)
		find_parent("HUD").holding_item = temp_item

func left_click_not_holding(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	find_parent("HUD").holding_item = slot.item
	slot.pickFromSlot()
	find_parent("HUD").holding_item.global_position = get_global_mouse_position()

func update_stats():
	for i in range(equip_slots.size()):
		if PlayerInventory.equips.has(i):
			Stats.set_stats(PlayerInventory.equips[i][0])
