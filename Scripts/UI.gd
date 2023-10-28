extends CanvasLayer

func Open():
	var t = create_tween().set_parallel().set_trans(Tween.TRANS_EXPO)
	t.tween_property($ColorRect, "position:y", -100, .2)
	t.tween_property($ColorRect, "position:y", 648, .2)

func Close():
	var t = create_tween().set_parallel().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	t.tween_property($ColorRect, "position:y", 0, .2)
	t.tween_property($ColorRect, "position:y", 548, .2)
