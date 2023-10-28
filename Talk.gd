extends Area2D

@export var Doc: Resource
@onready var Text = get_node("Speech/RichTextLabel")
var i = 0

func _ready(): $Label.scale = Vector2.ZERO



func Prompt(drop):
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	if !drop:
		t.tween_property($Label, "scale", Vector2.ONE, .2)
	else:
		t.tween_property($Label, "scale", Vector2.ZERO, .2)

func Next():
	if i == 0:
		Text.text = Doc.get_csv_line(i)
