extends Node

var attr = ["Health","Strength","Wisdom","Agility","Dexerity"]
var requested = {}
var currentMade = {}
var is_dragging = false
var needAdd = false
var node = ""
var level = 3
var piecesInside = {"ZShape":{},"LShape":{},"TShape":{},"IShape":{},"Square_shape":{},"FillerShape":{}}
var achieved = true
var roundEnd = false
var sum = 0
var eachAttrAchieved = {}
var handInDetect = false

var handFlashing = false;
var handFlashesDefault = 9;
var handFlashes = handFlashesDefault;


func _ready():
	reset()
	
func _process(delta):
	#checkAchieved()
	achieved = checkAchieved()
			
func checkAchieved():
	sum = 0
	var done = true
	for x in requested.keys():
		if x not in currentMade.keys():
			done = done and false
			if !eachAttrAchieved.has(x):
				eachAttrAchieved[x] = false
			
		else:
			done = done and true
			eachAttrAchieved[x] = true
	#var sum = 0
	for x in piecesInside.keys():
		if x != "FillerShape":
			sum += piecesInside[x].size()*4
		else:
			sum += piecesInside[x].size()
			
	if sum < 28:
		done = done and false
		
	return done

func reset():
	piecesInside = {"ZShape":{},"LShape":{},"TShape":{},"IShape":{},"Square_shape":{},"FillerShape":{}}
	requested = {}
	currentMade = {}
	is_dragging = false
	needAdd = false
	node = ""
	sum = 0
	eachAttrAchieved = {}
