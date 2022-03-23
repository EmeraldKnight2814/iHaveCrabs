extends KinematicBody2D

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
export var lives = 2

onready var sprite = $AnimatedSprite
onready var hitboxA = $HitBoxA
onready var hitboxB = $HitBoxB
onready var hurtbox = $HurtBox
onready var scream = $WilhelmScream

var knockback = Vector2.ZERO

func _ready():
	var crab_colors = sprite.frames.get_animation_names()
	sprite.animation = crab_colors[randi() % crab_colors.size()]
	lives = 2

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_HurtBox_area_entered(area):
	lives -= 1
	if lives <= 0:
		print("Crab Killed!")
		scream.play()
		queue_free()
	else:
		knockback = area.knockback_vector * 200
