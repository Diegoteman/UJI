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
	Prompt(true)
	GD.Player.canMove = false
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
	
