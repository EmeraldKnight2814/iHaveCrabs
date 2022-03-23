extends KinematicBody2D

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
export var lives = 2

onready var sprite = $AnimatedSprite
onready var hitboxA = $HitBoxA
onready var hitboxB = $HitBoxB
onready var hurtbox = $HurtBox
onready var scream = $WilhelmScream


func _ready():
	var crab_colors = sprite.frames.get_animation_names()
	sprite.animation = crab_colors[randi() % crab_colors.size()]
	lives = 2

func _on_HurtBox_area_entered(area):
	print("Crab Killed!")
	scream.play()
	queue_free()
