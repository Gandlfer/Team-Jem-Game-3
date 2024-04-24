extends Node

var attr = ["Health","Strength","Wisdom","Agility","Dexerity"]
var requested = {}
var currentMade = {}
var is_dragging = false
var needAdd = false
var node = ""
var level = 3
var piecesInside = {"ZShape":{},"LShape":{},"TShape":{},"IShape":{},"Square_shape":{}}
var achieved = true
var roundEnd = false

func _ready():
	reset()
	
func _process(delta):
	#checkAchieved()
	achieved = checkAchieved()
			
func checkAchieved():
	var done = true
	for x in requested.keys():
		if x not in currentMade.keys():
			done = done and false
		else:
			done = done and true
			
	return done

func reset():
	piecesInside = {"ZShape":{},"LShape":{},"TShape":{},"IShape":{},"Square_shape":{}}
	requested = {}
	currentMade = {}
	is_dragging = false
	needAdd = false
	node = ""
