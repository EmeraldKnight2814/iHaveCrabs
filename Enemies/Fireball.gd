extends Area2D

var speed = 5000

func _ready():
	$CollisionShape2D.disabled = true
	yield(get_tree().create_timer(1.1), "timeout")
	$CollisionShape2D.disabled = false

func _physics_process(delta):
	position += transform.x * speed * delta



func _on_Fireball_area_entered(area):
	queue_free()

func _on_Fireball_body_entered(body):
	queue_free()
