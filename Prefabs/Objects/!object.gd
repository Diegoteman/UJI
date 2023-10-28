extends Area2D

var pickedUp = false

func _ready(): $Label.scale = Vector2.ZERO

func Prompt(drop):
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	if !drop:
		t.tween_property($Label, "scale", Vector2.ONE, .2)
	else:
		t.tween_property($Label, "scale", Vector2.ZERO, .2)
