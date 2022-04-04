extends Node2D

func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://Cards/Templates/Enemy_Card_Template_CROWLEY.png")
	else:
		$TextureRect.texture = load("res://Cards/Templates/Basic_Card_Template_CROWLEY.png")
