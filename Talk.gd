extends Area2D

@export_file("*txt") var Doc
@export var DefaultTalkSpeed = .05
var talkSpeed = DefaultTalkSpeed
@onready var Text: RichTextLabel = get_node("Speech/RichTextLabel")
@onready var file = FileAccess.open(Doc, FileAccess.READ).get_as_text().replace("\r", "").split("\n")
@onready var names = file[0].split(", ")
@onready var T = Timer.new()
@onready var Arrow = get_node("Speech/Arrow")
var i = 1
var talking = false

func _ready():
	$Speech.scale = Vector2.ZERO
	$Label.scale = Vector2.ZERO
	GD.Reparent(T)

func _process(delta):
	if Input.is_action_pressed("Haunt"): talkSpeed = DefaultTalkSpeed / 2
	else: talkSpeed = DefaultTalkSpeed



func Prompt(drop):
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	if !drop:
		t.tween_property($Label, "scale", Vector2.ONE, .2)
	else:
		t.tween_property($Label, "scale", Vector2.ZERO, .2)

func Next():
	if talking: return
	if i == file.size():
		i = 1
		Close()
		UI.Open()
		Text.text = ""
		return
	if i == 1:
		Open()
		UI.Close()
	var msg = file[i]
	if int(msg[0]) == 0:
		Arrow.position.x = 20
		Arrow.rotation_degrees = -144.7
	else:
		Arrow.position.x = 160
		Arrow.rotation_degrees = -215.3
	var person = names[int(msg[0])]
	Talk(person + ": " + msg.replace("0 ", "").replace("1 ", ""))
	i += 1

func Talk(msg: String):
	talking = true
	Text.text = msg
	T.start()
	prints(msg, msg.length())
	for j in msg.length():
		T.wait_time = talkSpeed
		Text.visible_characters = j
		await T.timeout
	T.stop()
	talking = false

func Open():
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	t.tween_property($Speech, "scale", Vector2.ONE, .4)

func Close():
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	t.tween_property($Speech, "scale", Vector2.ZERO, .4)
