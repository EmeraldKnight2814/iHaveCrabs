extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2:
		$TextureRect.texture = load("res://Cards/Templates/Basic_Card_Template_CROWLEY.png")
	else:
		$TextureRect.texture = load("res://Cards/Templates/MCardOutline_ROGERS.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
