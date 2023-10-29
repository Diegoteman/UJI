extends Area2D

var dead = false

func _ready():
	if GD.peaDead:
		dead = true
		$Sprite2D/AnimationPlayer.play("dead")

func Die():
	if dead: return
	dead = true
	GD.peaDead = true
	GD.Player.canMove = false
	UI.Close()
	$Camera2D.make_current()
	$Sprite2D/AnimationPlayer.play("off")
	$Wotr.emitting = true
	$Timer.start()
	await $Timer.timeout
	GD.Player.Scare()
	for i in range(120):
		$Sprite2D.position = Vector2(randi_range(-3,3), randi_range(-3,3)) * i / 30
		await get_tree().physics_frame
	$Sprite2D.position = Vector2.ZERO
	var confetti = load("res://Scenes/Confetti.tscn").instantiate()
	GD.Reparent(confetti, self)
	confetti.position = Vector2.ZERO
	$Sprite2D/AnimationPlayer.play("dead")
	var t = create_tween()
	t.tween_property(self, "scale", Vector2.ONE, .5).from(Vector2(1.5, .8)).set_trans(Tween.TRANS_SINE)
	$Wotr.emitting = false
	for i in range(10):
		$Camera2D.offset = Vector2(randi_range(-10, 10), randi_range(-10, 10))
		await get_tree().physics_frame
	$Timer.start()
	await $Timer.timeout
	GD.Player.get_node("Camera2D").make_current()
	GD.Player.canMove = true
	UI.Open()
