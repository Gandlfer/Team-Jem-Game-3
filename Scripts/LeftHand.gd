extends CharacterBody2D

const MAX_SPEED = 500
const ACCELERATION = 800
const FRICTION = 1000
@onready var hand_sprite = $HoldingHandPngClipart
var hand_closed = false
var hand_open_texture = preload("res://Scenes/Hands/leftOpen.png")
var hand_closed_texture = preload("res://Scenes/Hands/leftClosed.png")

func _physics_process(delta):
	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("move_left_l", "move_right_l", "move_up_l", "move_down_l")
	velocity = input_direction * MAX_SPEED
	
	if Input.is_action_pressed("grab_l"):
		hand_sprite.texture = hand_closed_texture
	else:
		hand_sprite.texture = hand_open_texture
