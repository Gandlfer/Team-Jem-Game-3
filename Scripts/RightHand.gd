extends CharacterBody2D

const MAX_SPEED = 1100
const ACCELERATION = 2600
const FRICTION = 550

var input = Vector2.ZERO

@onready var hand_sprite = $HoldingHandPngClipart
var hand_closed = false
var hand_open_texture = preload("res://Scenes/Hands/rightOpen.png")
var hand_closed_texture = preload("res://Scenes/Hands/rightClosed.png")

func _physics_process(delta):
	player_movement(delta)
	grab_visuals()
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()

func get_input():
	input.x = int(Input.is_action_pressed("move_right_r")) - int(Input.is_action_pressed("move_left_r"))
	input.y = int(Input.is_action_pressed("move_down_r")) - int(Input.is_action_pressed("move_up_r"))
	
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)
		
	if(position.x < 0 or position.x > 1920):
		velocity.x *= -1
	
	if(position.y < 0 or position.y > 1080):
		velocity.y *= -1
		
	move_and_slide()

func grab_visuals():
	if Input.is_action_pressed("grab_r"):
		hand_sprite.texture = hand_closed_texture
	else:
		hand_sprite.texture = hand_open_texture
