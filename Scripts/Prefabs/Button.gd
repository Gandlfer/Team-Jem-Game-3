extends TextureButton

var nextPuzzle = load("res://Scenes/Puzzle/Puzzle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.achieved:
		get_node(".").visible = true
		get_node(".").disabled = false
	else:
		get_node(".").visible = false
		get_node(".").disabled = true
	pass


func _on_pressed():
	Global.reset()
	if Global.level == 5:
		Global.level = 3
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")
	else:
		Global.level+=1
		#Global.reset()
		get_tree().change_scene_to_file("res://Scenes/Puzzle/Puzzle.tscn")
	
	#print("Next Scene")
	
	pass # Replace with function body.
