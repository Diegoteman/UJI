extends Sprite2D

@export var Speed = 800
@export var WaitTime = 1

var LastPoint: Node2D
var CurrentPoint: Node2D
var NextPoint: Node2D

@onready var Vision = get_node("Area2D")
@onready var T = Timer.new()

func _ready():
	GD.Reparent(T)
	T.wait_time = WaitTime
	
	#Get first point
	var closestDist = 100000000
	for Point in GD.Points:
		var dist = abs((Point.position - position).length())
		if dist < closestDist:
			closestDist = dist
			CurrentPoint = Point
	
	while true:
		#Get next point
		while NextPoint == LastPoint:
			NextPoint = get_node(CurrentPoint.NearbyPoints[randi() % (CurrentPoint.NearbyPoints.size())])
		
		#Move to point
		var t = create_tween()
		var pos = NextPoint.position
		var time = abs(position - pos).length() / Speed
		t.tween_property(Vision, "rotation", (position-pos).angle() + PI/2, .5)
		t.tween_property(self, "position", pos, time)
		await t.finished
		LastPoint = CurrentPoint
		CurrentPoint = NextPoint
		NextPoint = LastPoint
		T.start()
		await T.timeout
