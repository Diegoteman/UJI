extends CanvasLayer

func Open():
	var t = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.tween_property($ColorRect, "position:y", -100, .5)
	t.tween_property($ColorRect2, "position:y", 648, .5)

func Close():
	var t = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($ColorRect, "position:y", 0, .5)
	t.tween_property($ColorRect2, "position:y", 548, .5)
