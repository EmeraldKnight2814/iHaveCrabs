extends Area2D

var sprites = [preload("res://Sprites/Player/Arrows/Base_Arrow.png"),
				preload("res://Sprites/Player/Arrows/Death_Arrow.png"),
				preload("res://Sprites/Player/Arrows/Ocean_Arrow.png"),
				preload("res://Sprites/Player/Arrows/Volcano_Arrow.png"),]
var speed = 1000


func _ready():
	if Stats.current_weapon == 0:
		$Sprite.texture = sprites[0]
	elif Stats.current_weapon == 1:
		$Sprite.texture = sprites[1]
	elif Stats.current_weapon == 2:
		$Sprite.texture = sprites[2]
	elif Stats.current_weapon == 3:
		$Sprite.texture = sprites[3]
	else:
		$Sprite.texture = sprites[0]

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Arrow_body_entered(body):
	queue_free()


func _on_Arrow_area_entered(area):
	queue_free()
