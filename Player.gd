extends KinematicBody2D


var speed = 300
var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
