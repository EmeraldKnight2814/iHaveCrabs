extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var LIVES = 3

signal hit

enum{
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

onready var aniPlayer = $AnimationPlayer
onready var aniTree = $AnimationTree
onready var aniState = aniTree.get('parameters/playback')
onready var hurtbox = $Hurtbox
onready var hitbox = $HitboxPivot/SwordHitbox

func _ready():
	aniTree.active = true
	$HitboxPivot/SwordHitbox/CollisionShape2D.disabled = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ATTACK:
			attack_state(delta)
	
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	#aniTree.set('parameters/blend_position', input_vector)
	if input_vector != Vector2.ZERO:
		aniTree.set('parameters/walk/blend_position', input_vector)
		aniTree.set('parameters/idle/blend_position', input_vector)
		aniTree.set('parameters/attack/blend_position', input_vector)
		aniState.travel('walk')
	else:
		aniState.travel('idle')
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	
func attack_state(delta):
	aniState.travel('attack')
	
func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	emit_signal('hit')
