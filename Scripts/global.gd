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
