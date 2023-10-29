extends AudioStreamPlayer

@export_file("*ogg") var Song

func _ready():
	stream = load(Song)
	playing = true
