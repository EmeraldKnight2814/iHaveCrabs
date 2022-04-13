extends KinematicBody2D

const acceleration = 460
const max_speed = 225
var velocity = Vector2.ZERO
var item_name

var player = null
var being_picked_up = false

func _ready():
	item_name = "PCard"

func _physics_process(delta):
	if being_picked_up == true:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		var distance = global_position.distance_to(player.global_position)
		if distance < 10:
			PlayerInventory.add_item(item_name)
			queue_free()
	velocity = move_and_slide(velocity)

func pick_up_item(body):
	player = body
	being_picked_up = true
