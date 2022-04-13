extends CanvasLayer

signal start_game
signal unpause

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

#Open inv
func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()


func _on_Unpause_pressed():
	emit_signal("unpause")
