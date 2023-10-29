extends AudioStreamPlayer

@export_file("*txt") var Song

func _ready():
	stream = load(Song)
	playing = true
