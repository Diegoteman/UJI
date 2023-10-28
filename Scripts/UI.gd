extends CanvasLayer

func Open():
	var t = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.tween_property($ColorRect, "position:y", -100, .5)
	t.tween_property($ColorRect2, "position:y", 648, .5)

func Close():
	var t = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($ColorRect, "position:y", 0, .5)
	t.tween_property($ColorRect2, "position:y", 548, .5)

func _input(event):
	if Input.is_action_just_pressed("Debug"):
		await Trans1()
		Trans2()
		return
		Shake(10, 5)
		return
		await Red().finished
		Back()

func Red():
	var t = create_tween().set_trans(Tween.TRANS_CUBIC)
	return t.tween_property($ColorRect3, "color:a", .3, .5)

func Back():
	var t = create_tween().set_trans(Tween.TRANS_CUBIC)
	return t.tween_property($ColorRect3, "color:a", 0, .5)

func Shake(frames, strength):
	var cam = GD.Player.get_node("Camera2D")
	for i in range(frames):
		cam.offset = Vector2(randi_range(-strength, strength), randi_range(-strength, strength))
		await get_tree().physics_frame
	cam.offset = Vector2.ZERO

func Trans1():
	var t = create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($ColorRect4, "position:y", -150, 1).from(-1700)
	return t.finished

func Trans2():
	var t = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.tween_property($ColorRect4, "position:y", 1300, 1)
