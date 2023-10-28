extends ColorRect

@export_file("*txt") var Doc
@onready var file = FileAccess.open(Doc, FileAccess.READ).get_as_text().replace("\n", "          \n")
@onready var T = get_node("Timer")

func _ready():
	if !GD.FirstTime:
		queue_free()
		return
	
	GD.Player.get_node("Sprite2D/AnimationPlayer").play("Stop")
	visible = true
	GD.FirstTime = false
	GD.Player.canMove = false
	$Label.text = file
	
	T.wait_time = 1
	T.start()
	await T.timeout
	T.wait_time = .07
	for i in range(file.length()):
		$Label.visible_characters = i
		await T.timeout
	T.wait_time = 2.5
	await T.timeout
	T.stop()
	
	var t = create_tween()
	t.tween_property($Label, "modulate:a", 0, 2.5)
	t.tween_property($".", "modulate:a", 0, 2.5)
	await t.finished
	
	GD.Player.canMove = true
	GD.Player.get_node("Sprite2D/AnimationPlayer").play("Idle")
