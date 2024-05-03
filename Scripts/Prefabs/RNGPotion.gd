extends Node2D

var rng = RandomNumberGenerator.new()
var arr = []
#var checkingArr = []
const UNKNOWN = "?"
# Called when the node enters the scene tree for the first time.
func _ready():
	var tmp = ["Health","Strength","Wisdom","Agility","Dexerity"]
	var index
	if Global.level == 5:
		tmp = ["Health","Wisdom","Agility"]
		index = rng.randi_range(0,len(tmp)-1)
		arr.append(tmp[index])
		tmp.remove_at(index)
		
		index = rng.randi_range(0,len(tmp)-1)
		arr.append(tmp[index])
		tmp.remove_at(index)

	else:
		index = rng.randi_range(0,len(tmp)-1)
		arr.append(tmp[index])
		tmp.remove_at(index)
	#$PotionChoice.text = ToString()
	
	for x in arr:
		Global.requested[x]=""

func _process(delta):
	$PotionChoice.text = ToString()
	
func ToString():
	var msg = ""
	for x in len(arr):
		if Global.eachAttrAchieved[arr[x]] == true:
			msg = str(msg,arr[x])
		else:
			msg = str(msg,UNKNOWN)
		if len(arr) > 1 and x != len(arr)-1:
			msg = str(msg," and ")
	return msg
	#if len(arr) == 2:
		#return str(arr[0]," and ",arr[1])
	#else :
		#return arr[0]

