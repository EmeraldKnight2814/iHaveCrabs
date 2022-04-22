extends CanvasLayer

signal restart_game
signal unpause

var holding_item = null


#Open inv
func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()
		if (!$Inventory.visible):
			Stats.reset()
			$Inventory.update_stats()

func _on_Unpause_pressed():
	emit_signal("unpause")


func _on_Quit_pressed():
	get_tree().quit()


func _on_RestartButton_pressed():
	emit_signal("restart_game")
