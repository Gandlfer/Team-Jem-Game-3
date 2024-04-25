extends Control

var winSound : AudioStream
var winPlayer : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	winSound = preload("res://Audio/violin-win-5-185128.mp3")
	winPlayer = AudioStreamPlayer.new()
	winPlayer.stream = winSound
	winPlayer.volume_db = -10
	add_child(winPlayer)
	winPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	Global.level=3
	get_tree().change_scene_to_file("res://Scenes/Puzzle/Puzzle.tscn")


func _on_main_menu_pressed():
	Global.level=3
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
