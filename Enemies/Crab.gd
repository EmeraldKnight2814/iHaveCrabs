extends KinematicBody2D

signal Crab_Killed

#bulk of code based off of uheartbeast tutorial (Github: https://github.com/uheartbeast/youtube-tutorials/tree/master/Action%20RPG)
enum{
	IDLE,
	WANDER,
	CHASE
}

export var HIT_POINTS = 75
export var FRICTION = 100
export var VELOCITY = Vector2.ZERO
export var ACCELERATION = 200
export var MAX_SPEED = 30
export var WANDER_TARGET_RANGE = 4

var knockback = Vector2.ZERO
var collision_disabled = false

var state = IDLE

onready var sprite = $AnimatedSprite
onready var hitboxA = $HitBoxA
onready var hitboxB = $HitBoxB
onready var hurtbox = $HurtBox
onready var zoneOfTruth = $PlayerDetectionZone
onready var wanderController = $Wander_Controller
onready var geraldStats = PlayerStats


func _ready():
	randomize()
	var crab_colors = sprite.frames.get_animation_names()
	sprite.animation = crab_colors[randi() % crab_colors.size()]
	HIT_POINTS = 75

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
			else:
				state = IDLE
	VELOCITY = move_and_slide(VELOCITY)

func disable_collision_shapes():
	collision_disabled = true
	$HurtBox/CollisionShape2D.disabled = true
	$HitBoxA/CollisionShape2D.disabled = true
	$HitBoxB/CollisionShape2D.disabled = true
	$PlayerDetectionZone/CollisionShape2D.disabled = true

func reenable_collision_shapes():
	if collision_disabled == true:
		collision_disabled = false
		$HurtBox/CollisionShape2D.disabled = false
		$HitBoxA/CollisionShape2D.disabled = false
		$HitBoxB/CollisionShape2D.disabled = false
		$PlayerDetectionZone/CollisionShape2D.disabled = false

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

func _on_HurtBox_area_entered(area):
	if area.name == "SwordHitbox":
		HIT_POINTS -= geraldStats.damage
		if HIT_POINTS <= 0:
			print("Crab Killed!")
			emit_signal("Crab_Killed")
			queue_free()
		else:
			knockback = area.knockback_vector * 200
			print("Crab has " + str(HIT_POINTS) + " Hit Points Left")
	elif area.name == "Fireball":
		HIT_POINTS = 0
		print("Crab Killed!")
		emit_signal("Crab_Killed")
		queue_free()
	elif area.name == "Arrow":
		HIT_POINTS -= geraldStats.damage
		if HIT_POINTS <= 0:
			print("Crab Killed!")
			emit_signal("Crab_Killed")
			queue_free()

func drop_item():
	PlayerInventory.random_drop()
