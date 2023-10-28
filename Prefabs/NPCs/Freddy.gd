extends Area2D

var dead = false

func Die():
	if dead: return
	dead = true
	GD.Player.canMove = false
	UI.Close()
	$Camera2D.make_current()
	$NPC/AnimationPlayer.play("Scare")
	GD.Player.Scare()
	for i in range(120):
		$NPC.position = Vector2(randi_range(-3,3), randi_range(-3,3)) * i / 60
		await get_tree().physics_frame
	var confetti = load("res://Scenes/Confetti.tscn").instantiate()
	GD.Reparent(confetti, self)
	confetti.position = Vector2.ZERO
	prints(confetti.global_position, confetti.get_parent(), confetti.emitting)
	$NPC.self_modulate = Color.TRANSPARENT
	for i in range(20):
		$Camera2D.offset = Vector2(randi_range(-10, 10), randi_range(-10, 10))
		await get_tree().physics_frame
	$Timer.start()
	await $Timer.timeout
	GD.Player.get_node("Camera2D").make_current()
	GD.Player.canMove = true
	UI.Open()