extends Area2D

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
		t.tween_property($Sprite2D, "scale", Vector2.ONE*2, .2)
	else:
		t.tween_property($Sprite2D, "scale", Vector2.ZERO, .2)



func _input(event):
	if Input.is_action_just_pressed("Haunt") && playerIn: Possess()

func Possess():
	pass
