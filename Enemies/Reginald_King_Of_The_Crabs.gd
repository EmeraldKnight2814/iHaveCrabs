extends KinematicBody2D

signal King_Crab_Killed

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
enum{
	IDLE,
	WANDER,
	CHASE
}

var fireball = preload("res://Enemies/Fireball.tscn")

export var HIT_POINTS = 0
export var FRICTION = 200
export var VELOCITY = Vector2.ZERO
export var ACCELERATION = 500
export var MAX_SPEED = 50
export var WANDER_TARGET_RANGE = 4
export var fireballLoopcheck = 100

onready var MAX_HIT_POINTS = PlayerStats.wizard_max_hit_points

var knockback = Vector2.ZERO
var state = IDLE
var fireballLoop = 100
var collision_disabled = false

onready var sprite = $AnimatedSprite
onready var hurtbox = $HurtBox
onready var zoneOfTruth = $PlayerDetectionZone
onready var zoneOfTruthShape = $PlayerDetectionZone/CollisionShape2D
onready var wanderController = $Wander_Controller


func _ready():
	randomize()
	var crab_colors = sprite.frames.get_animation_names()
	sprite.animation = crab_colors[randi() % crab_colors.size()]
	HIT_POINTS = MAX_HIT_POINTS
	add_to_group("enemy")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			VELOCITY = VELOCITY.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = zoneOfTruth.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				VELOCITY = VELOCITY.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				$FireStarter.rotate($FireStarter.get_angle_to(player.global_position))
				if fireballLoop == fireballLoopcheck:
					fire(player)
					fireballLoop = 1
				else:
					fireballLoop += 1
			else:
				state = IDLE
	VELOCITY = move_and_slide(VELOCITY)

func disable_collision_shapes():
	collision_disabled = true
	$HurtBox/CollisionShape2D.set_deferred("disabled", true)
	$PlayerDetectionZone/CollisionShape2D.set_deferred("disabled", true)
	

func reenable_collision_shapes():
	if collision_disabled == true:
		collision_disabled = false
		$HurtBox/CollisionShape2D.set_deferred("disabled", false)
		$PlayerDetectionZone/CollisionShape2D.set_deferred("disabled", false)

func seek_player():
	if zoneOfTruth.can_see_player():
		state = CHASE

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	VELOCITY = VELOCITY.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func fire(player):
	var fire = fireball.instance()
	fire.transform = $FireStarter.global_transform
	owner.owner.owner.add_child(fire)



func _on_HurtBox_area_entered(area):
	var layer = area.get_collision_layer()
	print("The layer that collided was: ")
	print(layer)
	#if area is sword
	if layer == 32:
		HIT_POINTS -= PlayerStats.damage
		if HIT_POINTS <= 0:
			emit_signal("King_Crab_Killed")
			queue_free()
		else:
			$Hit.play()
			knockback = area.knockback_vector * 200
	#if area is fireball
	elif layer == 128:
		print("Crab hit by Fireball")
		HIT_POINTS -= 100
		emit_signal("Crab_Killed")
		queue_free()
	elif layer == 512:
		HIT_POINTS -= PlayerStats.damage
		print("Crab hit by Arrow")
		if HIT_POINTS <= 0:
			emit_signal("Crab_Killed")
			queue_free()
		else:
			$Hit.play()
