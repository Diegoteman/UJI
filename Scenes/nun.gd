extends Area2D

var dead = false

func Die():
	if dead: return
	dead = true
	$NPC.visible = false
	$Sprite2D.visible = true
	$Sprite2D/AnimationPlayer.play("scare")
	for i in range(240):
		$NPC.position = Vector2(randi_range(-3,3), randi_range(-3,3)) * i / 60
		await get_tree().physics_frame
	$NPC.self_modulate = Color.TRANSPARENT
	for i in range(20):
		$Camera2D.offset = Vector2(randi_range(-2, 2), randi_range(-2, 2))
		await get_tree().physics_frame
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	var t = create_tween()
	t.tween_property($Sprite2D2, "scale", Vector2.ONE*2, .5).from(Vector2(1.5, .8)*2).set_trans(Tween.TRANS_SINE)
	UI.Open()
