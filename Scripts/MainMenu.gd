extends TextureRect

func _on_start_button_down():
	await UI.Trans1()
	get_tree().change_scene_to_file("res://Scenes/Piso1.tscn")
	UI.Trans2()
	GD.FindRoot()

func _on_help_button_down():
	var t = create_tween()
	t.tween_property($Helpscreen, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)

func _input(event):
	if Input.is_action_just_pressed("Haunt"):
		var t = create_tween()
		t.tween_property($Helpscreen, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)

func _on_quit_button_up():
	get_tree().quit()
