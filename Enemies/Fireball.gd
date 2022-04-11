extends Area2D

var speed = 5000
var redirectVector = Vector2.ZERO
var hitByPlayer = false
onready var sprite = $Sprite

func _ready():
	$CollisionShape2D.disabled = true
	yield(get_tree().create_timer(.2), "timeout")
	$CollisionShape2D.disabled = false

func _physics_process(delta):
	if hitByPlayer == false:
		position += transform.x * speed * delta
	else:
		position -= transform.x * speed * delta


func _on_Fireball_area_entered(area):
	if area.name == "SwordHitbox":
		hitByPlayer = true
		sprite.set_flip_h(true)
		sprite.set_flip_v(true)
	else:
		queue_free()

func _on_Fireball_body_entered(body):
	queue_free()
