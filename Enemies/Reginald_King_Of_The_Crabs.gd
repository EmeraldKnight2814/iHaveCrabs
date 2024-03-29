extends KinematicBody2D

signal King_Crab_Killed
signal King_Crab_Hit

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
enum{
	IDLE,
	WANDER,
	CHASE
}

var fireball = preload("res://Enemies/Fireball.tscn")

export var HIT_POINTS = 500
export var FRICTION = 200
export var VELOCITY = Vector2.ZERO
export var ACCELERATION = 5000
export var MAX_SPEED = 100
export var WANDER_TARGET_RANGE = 4
export var fireballLoopcheck = 250

var knockback = Vector2.ZERO
var state = IDLE
var fireballLoop = fireballLoopcheck
var collision_disabled = false
var main = JsonData.main

onready var sprite = $AnimatedSprite
onready var hurtbox = $HurtBox
onready var zoneOfTruth = $PlayerDetectionZone
onready var zoneOfTruthShape = $PlayerDetectionZone/CollisionShape2D
onready var wanderController = $Wander_Controller

func _ready():
	sprite.animation = "King"

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
					sprite.animation = "King"
				elif fireballLoop >= (fireballLoopcheck - 50):
					sprite.animation = "Fireball Prep"
					fireballLoop += 1
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
	fire.scale.x = 0.15
	fire.scale.y = 0.15
	JsonData.main.add_child(fire)

func _on_HurtBox_area_entered(area):
	var layer = area.get_collision_layer()
	print("The layer that collided was: ")
	print(layer)
	#if area is sword
	if layer == 32:
		HIT_POINTS -= PlayerStats.damage
		Stats.reginald_hp = HIT_POINTS
		if HIT_POINTS <= 0:
			emit_signal("King_Crab_Killed")
			queue_free()
		else:
			emit_signal("King_Crab_Hit")
			$Hit.play()
			knockback = area.knockback_vector * 500
	#if area is fireball
	elif layer == 128:
		HIT_POINTS -= 100
		Stats.reginald_hp = HIT_POINTS
		if HIT_POINTS <= 0:
			emit_signal("King_Crab_Killed")
			queue_free()
		else:
			emit_signal("King_Crab_Hit")
			$Hit.play()
	elif layer == 512:
		HIT_POINTS -= PlayerStats.damage
		Stats.reginald_hp = HIT_POINTS
		if HIT_POINTS <= 0:
			emit_signal("King_Crab_Killed")
			queue_free()
		else:
			emit_signal("King_Crab_Hit")
			$Hit.play()
