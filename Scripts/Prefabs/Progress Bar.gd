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
		get_node(x).value = Global.piecesInside[x].size() * 33.3
		var attr 
		match x:
			"ZShape":
				attr = "Health"
			"LShape":
				attr = "Wisdom"
			"TShape":
				attr = "Agility"
			"IShape":
				attr = "Strength"
			"Square_shape":
				attr = "Dexerity"
		if Global.piecesInside[x].size() >= 3:
			Global.currentMade[attr]= ""
		else:
			Global.currentMade.erase(attr)
