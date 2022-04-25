extends Area2D

var sprites = [preload("res://Sprites/Player/Arrows/Base_Arrow.png"),
				preload("res://Sprites/Player/Arrows/Death_Arrow.png"),
				preload("res://Sprites/Player/Arrows/Ocean_Arrow.png"),
				preload("res://Sprites/Player/Arrows/Volcano_Arrow.png"),]
var speed = 1000
var gerald_stats = PlayerStats

func _ready():
	if gerald_stats.current_weapon == 0:
		$Sprite.texture = sprites[0]
	elif gerald_stats.current_weapon == 1:
		$Sprite.texture = sprites[1]
	elif gerald_stats.current_weapon == 2:
		$Sprite.texture = sprites[2]
	elif gerald_stats.current_weapon == 3:
		$Sprite.texture = sprites[3]
	else:
		$Sprite.texture = sprites[0]

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Arrow_body_entered(body):
	print("Arrow Hit Something")
	queue_free()


func _on_Arrow_area_entered(area):
	print("Arrow Hit Something")
	queue_free()
