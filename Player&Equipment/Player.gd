extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 150

signal hit

enum{
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var stats = PlayerStats
var sprites = [preload("res://Sprites/Player/Player_BaseSet.png"), preload("res://Sprites/Player/Player_DeathSet.png"), preload("res://Sprites/Player/Player_OceanSet.png"), preload("res://Sprites/Player/Player_VolcanoSet.png")]
var currentSprite = sprites[0]

onready var aniPlayer = $AnimationPlayer
onready var aniTree = $AnimationTree
onready var aniState = aniTree.get('parameters/playback')
onready var hurtbox = $Hurtbox
onready var hitbox = $HitboxPivot/SwordHitbox
onready var hitboxCollisionShape = $HitboxPivot/SwordHitbox/CollisionShape2D
onready var armor = $Sprite

func _ready():
	aniTree.active = true
	hitboxCollisionShape.disabled = true
	hitbox.knockback_vector = Vector2.ZERO
	stats.connect("no_hit_points", self, "queue_free")

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
		hitbox.knockback_vector = input_vector
		aniTree.set('parameters/walk/blend_position', input_vector)
		aniTree.set('parameters/idle/blend_position', input_vector)
		aniTree.set('parameters/attack/blend_position', input_vector)
		aniState.travel('walk')
	else:
		aniState.travel('idle')
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func updateArmorSet(index):
	currentSprite = sprites[index]
	armor.texture = currentSprite
	
func attack_state(delta):
	aniState.travel('attack')
	
func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.hit_points -= 1
	emit_signal('hit')
