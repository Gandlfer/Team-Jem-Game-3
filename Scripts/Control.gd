extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$SoundBG.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Cut_Scenes/cut_scene_1.tscn")


func _on_story_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Story.tscn")


func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/instructions.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
