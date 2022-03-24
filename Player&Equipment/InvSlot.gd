extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var CardClass = preload("res://Player&Equipment/Card.tscn")
var card = null

func _ready():
	if randi() % 2 == 0:
		card = CardClass.instance()
		add_child(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
