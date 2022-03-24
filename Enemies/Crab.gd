extends KinematicBody2D

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
enum{
	IDLE,
	WANDER,
	CHASE
}

export var HIT_POINTS = 2
export var FRICTION = 200
export var VELOCITY = Vector2.ZERO
export var ACCELERATION = 200
export var MAX_SPEED = 80

var knockback = Vector2.ZERO

var state = IDLE

onready var sprite = $AnimatedSprite
onready var hitboxA = $HitBoxA
onready var hitboxB = $HitBoxB
onready var hurtbox = $HurtBox
onready var scream = $WilhelmScream
onready var zoneOfTruth = $PlayerDetectionZone


func _ready():
	var crab_colors = sprite.frames.get_animation_names()
	sprite.animation = crab_colors[randi() % crab_colors.size()]
	HIT_POINTS = 2

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			VELOCITY = VELOCITY.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = zoneOfTruth.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				VELOCITY = VELOCITY.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	VELOCITY = move_and_slide(VELOCITY)

func seek_player():
	if zoneOfTruth.can_see_player():
		state = CHASE

func _on_HurtBox_area_entered(area):
	if HIT_POINTS <= 0:
		print("Crab Killed!")
		scream.play()
		queue_free()
	else:
		knockback = area.knockback_vector * 100
		HIT_POINTS -= 1
