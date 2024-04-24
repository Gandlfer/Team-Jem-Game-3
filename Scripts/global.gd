extends Node

var attr = ["Health","Strength","Wisdom","Agility","Dexerity"]
var requested = {}
var currentMade = {}
var is_dragging = false
var needAdd = false
var node = ""
var level = 5
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
	var sum = 0
	for x in piecesInside.keys():
		sum += len(piecesInside[x].keys())
		#if piecesInside[x].keys()
	if (sum*4) < 28:
		done = done and false
	return done

func reset():
	piecesInside = {"ZShape":{},"LShape":{},"TShape":{},"IShape":{},"Square_shape":{}}
	requested = {}
	currentMade = {}
	is_dragging = false
	needAdd = false
	node = ""
