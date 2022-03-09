extends CanvasLayer

signal start_game

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
