extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ZShape.rounded = true
	$LShape.rounded = true
	$TShape.rounded = true
	$IShape.rounded = true
	$Square_shape.rounded = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for x in Global.piecesInside.keys():
		#if Global.piecesInside[x].size() == 3
		get_node(x).value = Global.piecesInside[x].size() * 33.3
	pass
