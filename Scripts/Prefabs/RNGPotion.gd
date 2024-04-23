extends Node2D

var rng = RandomNumberGenerator.new()
var arr = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var tmp = Global.attr
	var index
	if Global.level == 5:
		index = rng.randi_range(0,len(tmp)-1)
		#print(index)
		arr.append(tmp[index])
		tmp.remove_at(index)
		#print("Length ",len(tmp))
		index = rng.randi_range(0,len(tmp)-1)
		#print(index)
		arr.append(tmp[index])
		tmp.remove_at(index)
		#print("Length ",len(tmp))
	else:
		index = rng.randi_range(0,len(tmp)-1)
		arr.append(tmp[index])
		tmp.remove_at(index)
	$PotionChoice.text = ToString()
	
	for x in arr:
		Global.requested[x]=""

func ToString():
	var str = ""
	if len(arr) == 2:
		return str(arr[0]," and ",arr[1])
	else :
		return arr[0]

