extends KinematicBody2D


const ACCELERATION = 500
const MAX_SPEED = 200


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
	

func _physics_process(delta):
	velocity = move_and_slide(velocity)

