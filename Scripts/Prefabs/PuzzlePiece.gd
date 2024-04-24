extends Control

@export var collided = false
var outofbound = false
var blocked = false
var dropable = false
var pieces = false

var collidedPiecesList = {}

# Audio variables
var dropSound : AudioStream
var pickupSound : AudioStream
var blockedSound : AudioStream
var outOfBoundsSound : AudioStream
var bgMusic : AudioStreamMP3  # Background music variable

var audioPlayer : AudioStreamPlayer
var bgMusicPlayer : AudioStreamPlayer  # Background music player

# Called when the node enters the scene tree for the first time.
func _ready():
	dropSound = preload("res://Audio/clothes-drop-2-40202.mp3")
	pickupSound = preload("res://Audio/paper-collect-6-186720.mp3")
	bgMusic = load("res://Audio/027682_boss39s-music-for-gamemp3-68640.mp3")
	
	audioPlayer = AudioStreamPlayer.new()
	add_child(audioPlayer)
	
	bgMusicPlayer = AudioStreamPlayer.new()  # Create a new AudioStreamPlayer for the background music
	bgMusic.loop = true  # Set loop to true for the background music
	bgMusicPlayer.stream = bgMusic
	bgMusicPlayer.volume_db = -35
	add_child(bgMusicPlayer)
	
	bgMusicPlayer.play()  # Play the background music
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(!outofbound," ", !blocked ," ", dropable)
	if collidedPiecesList.size()>0:
		collided = false and dropable #and !pieces
	else:
		collided = true and dropable #and !pieces
	#collided = !outofbound and !blocked and dropable and !pieces
	#print(collidedPiecesList.size())
	#if collided == true:
		#print(collided)
	pass

# Input handling
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_action_pressed("left_mouse_click"):
					# Detect when the left mouse button is pressed
					_on_mouse_click()
		else:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_action_released("left_mouse_click"):
					# Detect when the left mouse button is released
					_on_mouse_release()

# Function to handle mouse click
func _on_mouse_click():
	#if pieces:
		audioPlayer.stream = pickupSound
		audioPlayer.volume_db = -21  # Lower the volume
		audioPlayer.play()
		print("Mouse clicked. Playing pickup sound.")

# Function to handle mouse release
func _on_mouse_release():
	#if pieces and dropable:
	if dropable:
		audioPlayer.stream = dropSound
		audioPlayer.volume_db = -20  # Lower the volume
		audioPlayer.play()
		print("Mouse released. Playing drop sound.")

func _on_area_2d_body_entered(body):
	#print(get_child(0))
	#print(body)
	#print(get_child(0)==body)
	if body.is_in_group("PuzzlePiece") and !(get_child(0)==body):
		#print("Something")
		#print("PuzzlePiece ",body.get_node("../Label").text,body.get_node("../../..").name)
		#collidedPiecesList[body.get_node("../../..").name] = ""
		#print(collidedPiecesList)
		pieces = true
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("PuzzlePiece") and !(get_child(0)==body):
		#print("Exit PuzzlePiece ",body.get_node("../Label").text,body.get_node("../../..").name)
		#collidedPiecesList.erase(body.get_node("../../..").name)
		#print(collidedPiecesList)
		pieces = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("OutofBounds"):
		#print("OutofBounds ",area.name)
		collidedPiecesList[area.name] = ""
		outofbound = true
	if area.is_in_group("BlockedBox"):
		#print("BlockedBox ",area.get_node("../../Label").text)
		collidedPiecesList[area.get_node("../../Label").text] = ""
		blocked = true
	if area.is_in_group("Dropable"):
		#print("Dropable ",area.get_node("..").name)
		dropable = true
		#print("In")

func _on_area_2d_area_exited(area):
	if area.is_in_group("Dropable"):
		#print("Out")
		dropable = false
	if area.is_in_group("BlockedBox"):
		collidedPiecesList.erase(area.get_node("../../Label").text)
		blocked = false
	if area.is_in_group("OutofBounds"):
		collidedPiecesList.erase(area.name)
		outofbound = false
		#print("Here")
