extends TextureRect

func _on_start_button_down():
	await UI.Trans1()
	get_tree().change_scene_to_file("res://Scenes/Piso1.tscn")
	UI.Trans2()
	GD.FindRoot()

func _on_help_button_down():
	pass # Replace with function body.

func _on_quit_button_up():
	get_tree().quit()
