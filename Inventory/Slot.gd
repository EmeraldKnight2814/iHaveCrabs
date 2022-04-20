extends Panel

var default_tex = preload("res://Inventory/UI_Sprites/buttonSquare_brown_pressed.png")
var empty_tex = preload("res://Inventory/UI_Sprites/buttonSquare_brown.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Inventory/Item.tscn")
var item = null
var slot_index

enum SlotType {
	HOTBAR = 0,
	INVENTORY,
	P,
	X
}

var slotType = null

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex

#	if randi() % 2 == 0:
#		item = ItemClass.instance()
#		add_child(item)
	refresh_style()

func refresh_style():
	if item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)

func pickFromSlot():
	remove_child(item)
	find_parent("HUD").add_child(item)
	item = null
	refresh_style()

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	find_parent("HUD").remove_child(item)
	add_child(item)
	refresh_style()

func initialize_item(item_name):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name)
	else:
		item.set_item(item_name)
	refresh_style()
