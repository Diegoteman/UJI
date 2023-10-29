extends Area2D

@export_file("*txt") var Doc1
@export_file("*txt") var Doc2
@export var DefaultTalkSpeed = .05
var talkSpeed = DefaultTalkSpeed
@onready var Text: RichTextLabel = get_node("Speech/RichTextLabel")
var files = []
var names = []
@onready var T = Timer.new()
@onready var Arrow = get_node("Speech/Arrow")
var i = 1
var k = 0
var talking = false

func _ready():
	files.append(FileAccess.open(Doc1, FileAccess.READ).get_as_text().replace("\r", "").split("\n"))
	names.append(files[0][0].split(", "))
	if Doc2:
		files.append(FileAccess.open(Doc2, FileAccess.READ).get_as_text().replace("\r", "").split("\n"))
		names.append(files[1][0].split(", "))
	$Speech.scale = Vector2.ZERO
	$Bocadillo.scale = Vector2.ZERO
	GD.Reparent(T)

func _process(delta):
	if Input.is_action_pressed("Haunt"): talkSpeed = DefaultTalkSpeed / 2
	else: talkSpeed = DefaultTalkSpeed



func Prompt(drop):
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	if !drop:
		t.tween_property($Bocadillo, "scale", Vector2.ONE*2, .2)
	else:
		t.tween_property($Bocadillo, "scale", Vector2.ZERO, .2)

func Next():
	if talking: return
	if i == files[k].size()-1:
		i = 1
		Close()
		UI.Open()
		GD.Player.canMove = true
		Text.text = ""
		if Doc2: k = 1
		return
	if i == 1:
		Open()
		UI.Close()
		GD.Player.canMove = false
	var msg = files[k][i]
	if names[k].size() == 1:
		Arrow.position.x = 90
		Arrow.rotation_degrees = 180
	elif int(msg[0]) == 0:
		Arrow.position.x = 57
		Arrow.rotation_degrees = -144.7
	else:
		Arrow.position.x = 133
		Arrow.rotation_degrees = -215.3
	var person = names[k][int(msg[0])]
	Talk(person, msg.replace("0 ", "").replace("1 ", ""))
	i += 1

func Talk(person: String, msg: String):
	talking = true
	Text.text = person + ": " + msg
	T.start()
	for j in range(person.length()+2, msg.length()+person.length()+2):
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
