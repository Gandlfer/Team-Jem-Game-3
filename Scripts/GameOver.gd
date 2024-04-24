extends Control

var gameOverSound : AudioStream
var gameOverSoundPlayer : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.reset()
	gameOverSound = preload("res://Audio/violin-lose-4-185125.mp3")
	gameOverSoundPlayer = AudioStreamPlayer.new()
	gameOverSoundPlayer.stream = gameOverSound
	gameOverSoundPlayer.volume_db = -10
	add_child(gameOverSoundPlayer)
	gameOverSoundPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/Puzzle/Puzzle.tscn")
