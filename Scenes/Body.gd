extends Area2D

@onready var T = get_node("Timer")
var playerIn = false

func _on_area_entered(area):
	playerIn = true
	Prompt(false)
func _on_area_exited(area):
	playerIn = false
	Prompt(true)

func Prompt(drop):
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	if !drop:
		t.tween_property($Label, "scale", Vector2.ONE*.4, .2)
	else:
		t.tween_property($Label, "scale", Vector2.ZERO, .2)



func _input(event):
	if Input.is_action_just_pressed("Haunt") && playerIn: Possess()

func Possess():
	$"../Nun/Camera2D".make_current()
	Prompt(true)
	GD.Player.canMove = false
	GD.Player.Sprite.flip_h = true
	UI.Close()
	var t = create_tween()
	t.tween_property(GD.Player, "modulate:a", 0, 2)
	await t.finished
	T.start()
	await T.timeout
	for i in range(60):
		$Sprite2D.position = Vector2(randi_range(-3,3), randi_range(-3,3)) * i / 60
		await get_tree().physics_frame
	$Sprite2D/AnimationPlayer.play("Do")
	T.start()
	await T.timeout
	$"../Nun".Die()
	T.start()
	await T.timeout
	t = create_tween()
	t.tween_property(GD.Player, "modulate:a", 1, 1)
	await t.finished
	GD.Player.Scare()
	T.wait_time = 3.3
	T.start()
	await T.timeout
	t = create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	t.tween_property(GD.Player, "position", $"../Nun/Camera2D".global_position, 1)
	t.tween_property($"../ColorRect2", "color:a", 1, 1)
	await t.finished
	GD.Player.Sprite.visible = false
	$"../Nun/Camera2D/Sprite2D".visible = true
	$"../Nun/Camera2D/Sprite2D/AnimationPlayer".play("ascend")
	t = create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	t.tween_property($"../Nun/Camera2D/Sprite2D", "position.y", position.y - 100, 8)
	t.tween_property($"../CharacterBody2D/PointLight2D2", "energy", 2, 8)
	t.tween_property($"../Nun/Camera2D/Sprite2D", "modulate.a", 0, 8)
	await t.finished
	$"../ColorRect3".visible = true
	$"../CharacterBody2D/PointLight2D2".queue_free()
	
