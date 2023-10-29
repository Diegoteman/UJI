extends Area2D

@onready var Obj = get_parent()

func _physics_process(delta):
	$CollisionShape2D.disabled = Obj.pickedUp
	if Obj.pickedUp:
		var dir = sign(GD.Player.velocity.x)
		if dir != 0 :scale.x = dir
		position = Vector2(30 * scale.x, 0)

func _on_terrarium_area_entered(area):
	if area.is_in_group("Femboy"): Break(area)

func Break(femboy):
	$CollisionShape2D
	$"../CollisionShape2D"
	UI.Close()
	GD.Player.canMove = false
	femboy.get_node("Camera2D").make_current()
	var t = create_tween()
	t.tween_property(self, "position:y", position.y+30, .3).set_trans(Tween.TRANS_SINE)
	await t.finished
	$Glass.emitting = true
	$Terrarium.visible = false
	$Broken.visible = true
	$Spider.visible = true
	$Timer.start()
	await $Timer.timeout
	$Spider/AnimationPlayer.play("skibidi")
	$Spider.flip_h = sign(position.x - 266) == 1
	t = create_tween()
	t.tween_property($Spider, "global_position", Vector2(266, 256), .2)
	t.tween_property($Spider, "global_position:y", 202, 1)
	await t.step_finished
	$Spider.rotation_degrees = 90
	await t.finished
	femboy.Die()
	$Spider.visible = false
