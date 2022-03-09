extends KinematicBody2D


export var speed = 200

var velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.

# Movement
func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _process(delta):
	pass

