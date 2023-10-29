extends Area2D

var dead = false

func _ready():
	if GD.femboyDead:
		dead = true
		$Sprite2D/AnimationPlayer.play("dead")

func Die():
	if dead: return
	dead = true
	GD.femboyDead = true
	UI.Close()
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	$Sprite2D2/AnimationPlayer.play("scared")
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
	$Sprite2D2.visible = false
	$Sprite2D3.visible = true
	var t = create_tween()
	t.tween_property($Sprite2D3, "scale", Vector2.ONE, .5).from(Vector2(1.5, .8)).set_trans(Tween.TRANS_SINE)
	for i in range(10):
		$Camera2D.offset = Vector2(randi_range(-10, 10), randi_range(-10, 10))
		await get_tree().physics_frame
	$Timer.start()
	await $Timer.timeout
	GD.Player.get_node("Camera2D").make_current()
	GD.Player.canMove = true
	UI.Open()
