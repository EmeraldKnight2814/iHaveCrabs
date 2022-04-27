extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 150

signal hit
signal armor_changed

enum{
	MOVE,
	ATTACK,
	DEAD
}

var state = MOVE
var velocity = Vector2.ZERO
var stats = PlayerStats
var arrow = preload("res://Player&Equipment/Arrow.tscn")

var sprites = [preload("res://Sprites/Player/Player_BaseSet.png"), #0
				preload("res://Sprites/Player/Player_DeathSet.png"), #1
				preload("res://Sprites/Player/Player_OceanSet.png"), #2
				preload("res://Sprites/Player/Player_VolcanoSet.png") #3
				]
var unmatchedSprites = [preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_BaseArmor_DeathWeapon.png"), #0
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_BaseArmor_OceanWeapon.png"), #1
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_BaseArmor_VolcanoWeapon.png"), #2
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_DeathArmor_BaseWeapon.png"), #3
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_DeathArmor_OceanWeapon.png"), #4
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_DeathArmor_VolcanoWeapon.png"), #5
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_OceanArmor_BaseWeapon.png"), #6
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_OceanArmor_DeathWeapon.png"), #7
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_OceanArmor_VolcanoWeapon.png"), #8
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_VolcanoArmor_BaseWeapon.png"), #9
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_VolcanoArmor_DeathWeapon.png"), #10
						preload("res://Sprites/Player/Unmatched_Weapon_And_Armor/Player_VolcanoArmor_OceanWeapon.png") #11
						]

onready var aniPlayer = $AnimationPlayer
onready var aniTree = $AnimationTree
onready var aniState = aniTree.get('parameters/playback')
onready var hurtbox = $Hurtbox
onready var hitbox = $HitboxPivot/SwordHitbox
onready var hitboxCollisionShape = $HitboxPivot/SwordHitbox/CollisionShape2D

func _ready():
	add_to_group("player")
	aniTree.active = true
	hitboxCollisionShape.disabled = true
	hitbox.knockback_vector = Vector2.ZERO
	stats.connect("no_hit_points", self, "_on_no_hit_points")

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ATTACK:
			attack_state(delta)
		DEAD:
			dead_state(delta)
	
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	#aniTree.set('parameters/blend_position', input_vector)
	if input_vector != Vector2.ZERO:
		hitbox.knockback_vector = input_vector * stats.knockback_modifier
		aniTree.set('parameters/walk/blend_position', input_vector)
		aniTree.set('parameters/idle/blend_position', input_vector)
		aniTree.set('parameters/attack/blend_position', input_vector)
		aniTree.set('parameters/bow/blend_position', input_vector)
		aniState.travel('walk')
	else:
		aniState.travel('idle')
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func updateSprite():
	if (Stats.current_weapon == Stats.current_armor):
		if(Stats.current_armor == 0): #Base Set
			print("Base Set")
			$Sprite.texture = sprites[0]
			PlayerStats.damage = 25
			PlayerStats.max_hit_points = 3
			emit_signal("armor_changed")
		elif(Stats.current_armor == 1): #Death Set
			print("Death Set")
			$Sprite.texture = sprites[1]
			PlayerStats.damage = 100
			PlayerStats.max_hit_points = 5
			emit_signal("armor_changed")
		elif(Stats.current_armor == 2): #Ocean Set
			print("Ocean Set")
			$Sprite.texture = sprites[2]
			PlayerStats.damage = 75
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		elif(Stats.current_armor == 3): #Volcano Set
			print("Volcano Set")
			$Sprite.texture = sprites[3]
			PlayerStats.damage = 50
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		else:
			print("Else used")
			$Sprite.texture = sprites[0]
			PlayerStats.damage = 25
			PlayerStats.max_hit_points = 3
			emit_signal("armor_changed")
	else:
		if(Stats.current_armor == 0 and Stats.current_weapon == 1): #Base Armor, Death Weapon, Index = 0
			print("Base Armor, Death Weapon")
			$Sprite.texture = unmatchedSprites[0]
			PlayerStats.damage = 100
			PlayerStats.max_hit_points = 3
			emit_signal("armor_changed")
		elif(Stats.current_armor == 0 and Stats.current_weapon == 2): #Base Armor, Ocean Weapon, Index = 1
			print("Base Armor, Ocean Weapon")
			$Sprite.texture = unmatchedSprites[1]
			PlayerStats.damage = 75
			PlayerStats.max_hit_points = 3
			emit_signal("armor_changed")
		elif(Stats.current_armor == 0 and Stats.current_weapon == 3): #Base Armor, Volcano Weapon, Index = 2
			print("Base Armor, Volcano Weapon")
			$Sprite.texture = unmatchedSprites[2]
			PlayerStats.damage = 50
			PlayerStats.max_hit_points = 3
			emit_signal("armor_changed")
		elif(Stats.current_armor == 1 and Stats.current_weapon == 0): #Death Armor, Base Weapon, Index = 3
			print("Death Armor, Base Weapon")
			$Sprite.texture = unmatchedSprites[3]
			PlayerStats.damage = 25
			PlayerStats.max_hit_points = 5
			emit_signal("armor_changed")
		elif(Stats.current_armor == 1 and Stats.current_weapon == 2): #Death Armor, Ocean Weapon, Index = 4
			print("Death Armor, Ocean Weapon")
			$Sprite.texture = unmatchedSprites[4]
			PlayerStats.damage = 75
			PlayerStats.max_hit_points = 5
			emit_signal("armor_changed")
		elif(Stats.current_armor == 1 and Stats.current_weapon == 3): #Death Armor, Volcano Weapon, Index = 5
			print("Death Armor, Volcano Weapon")
			$Sprite.texture = unmatchedSprites[5]
			PlayerStats.damage = 50
			PlayerStats.max_hit_points = 5
			emit_signal("armor_changed")
		elif(Stats.current_armor == 2 and Stats.current_weapon == 0): #Ocean Armor, Base Weapon, Index = 6
			print("Ocean Armor, Base Weapon")
			$Sprite.texture = unmatchedSprites[6]
			PlayerStats.damage = 25
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		elif(Stats.current_armor == 2 and Stats.current_weapon == 1): #Ocean Armor, Death Weapon, Index = 7
			print("Ocean Armor, Death Weapon")
			$Sprite.texture = unmatchedSprites[7]
			PlayerStats.damage = 100
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		elif(Stats.current_armor == 2 and Stats.current_weapon == 3): #Ocean Armor, Volcano Weapon, Index = 8
			print("Ocean Armor, Volcano Weapon")
			$Sprite.texture = unmatchedSprites[8]
			PlayerStats.damage = 50
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		elif(Stats.current_armor == 3 and Stats.current_weapon == 0): #Volcano Armor, Base Weapon, Index = 9
			print("Volcano Armor, Base Weapon")
			$Sprite.texture = unmatchedSprites[9]
			PlayerStats.damage = 25
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		elif(Stats.current_armor == 3 and Stats.current_weapon == 1): #Volcano Armor, Death Weapon, Index = 10
			print("Volcano Armor, Death Weapon")
			$Sprite.texture = unmatchedSprites[10]
			PlayerStats.damage = 100
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		elif(Stats.current_armor == 3 and Stats.current_weapon == 2): #Volcano Armor, Ocean Weapon, Index = 11
			print("Volcano Armor, Ocean Weapon")
			$Sprite.texture = unmatchedSprites[11]
			PlayerStats.damage = 75
			PlayerStats.max_hit_points = 4
			emit_signal("armor_changed")
		else:
			print("else used")
			$Sprite.texture = sprites[0]
			PlayerStats.damage = 25
			PlayerStats.max_hit_points = 3
			emit_signal("armor_changed")
	
func attack_state(delta):
	if (stats.weapon_type == 1):
		aniState.travel('attack')
	elif (stats.weapon_type == 2):
		aniState.travel('bow')
	else:
		stats.weapon_type = 1
		aniState.travel('attack')

func dead_state(delta):
	hide()
	$CollisionShape2D.disabled = true

func attack_animation_finished():
	state = MOVE

func bow_animation_finished():
	loose_arrow()
	state = MOVE

func loose_arrow():
	var a = arrow.instance()
	owner.add_child(a)
	a.transform = $Arrow_Start.global_transform

func _on_Hurtbox_area_entered(area):
	ouchie()
	stats.hit_points -= 1
	emit_signal('hit')

func _on_no_hit_points():
	state = DEAD
	

func ouchie():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	print("Hitbox disabled")
	$Sprite.modulate = Color(1, 0, 0)
	$Timer.start()

#TJ is writing this code btw Dan
func _input(event):
	if event.is_action_pressed("pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)


func _on_Timer_timeout():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", false)
	print("Hitbox reenabled")
	$Sprite.modulate = Color(1,1,1)
