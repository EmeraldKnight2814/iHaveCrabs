extends KinematicBody2D


func _ready():
	var crab_colors = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = crab_colors[randi() % crab_colors.size()]
	
"""
func _input(event):
	if event.is_action_pressed("reset_map_test"):
		var crab_colors = $AnimatedSprite.frames.get_animation_names()
		$AnimatedSprite.animation = crab_colors[randi() % crab_colors.size()]
"""




func _on_HurtBox_area_entered(area):
	queue_free()
