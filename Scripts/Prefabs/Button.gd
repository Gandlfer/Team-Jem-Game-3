extends TextureButton

var nextPuzzle = load("res://Scenes/Puzzle/Puzzle.tscn")
var appearSound
var audioPlayer : AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	appearSound = preload("res://Audio/sound-effect-twinklesparkle-115095.mp3")
	audioPlayer = AudioStreamPlayer.new()
	add_child(audioPlayer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.achieved:
		_on_pressed()
		#if !get_node(".").visible:
			#audioPlayer.stream = appearSound
			#audioPlayer.volume_db = -1  # Lower the volume
			#audioPlayer.play()
		#get_node(".").visible = true
		#get_node(".").disabled = false
	else:
		get_node(".").visible = false
		get_node(".").disabled = true


func _on_pressed():
	Global.reset()
	if Global.level == 5:
		Global.level = 3
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")
	elif Global.level == 4:
		Global.level+=1
		get_tree().change_scene_to_file("res://Scenes/Cut_Scenes/cut_scene_3.tscn")
	elif Global.level == 3:
		Global.level+=1
		get_tree().change_scene_to_file("res://Scenes/Cut_Scenes/cut_scene_2.tscn")
	#else:
		#Global.level+=1
		##Global.reset()
		##get_tree().change_scene_to_file("res://Scenes/Puzzle/Puzzle.tscn")
		#get_tree().change_scene_to_file("res://Scenes/Cut_Scenes/cut_scene_2.tscn")
	
	#print("Next Scene")
	
	pass # Replace with function body.
