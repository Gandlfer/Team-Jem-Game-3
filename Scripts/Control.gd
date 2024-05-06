extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if Mainmenubackground.stream_paused:
		Mainmenubackground.stream_paused=false
	else:
		Mainmenubackground.play_music_level()
	print("Here")
	#$SoundBG.play()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Cut_Scenes/cut_scene_1.tscn")
	Mainmenubackground.stop_music()
	Global.menuPlace = 1


func _on_story_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Story.tscn")
	Global.menuPlace = 2


func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/instructions.tscn")
	Global.menuPlace = 3

func _on_quit_button_pressed():
	get_tree().quit()
