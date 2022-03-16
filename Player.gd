extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 100

var velocity = Vector2.ZERO
var aniPlayer

onready var aniTree = $AnimationTree
onready var aniState = aniTree.get('parameters/playback')

func _ready():
	aniPlayer = $AnimationPlayer
	aniTree.active = true

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	#aniTree.set('parameters/blend_position', input_vector)
	if input_vector != Vector2.ZERO:
		aniTree.set('parameters/walk/blend_position', input_vector)
		aniState.travel('walk')
	else:
		aniState.travel('idle')

func _physics_process(delta):
	velocity = move_and_slide(velocity)

