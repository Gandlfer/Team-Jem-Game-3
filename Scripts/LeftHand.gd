extends CharacterBody2D

const MAX_SPEED = 1100
const ACCELERATION = 2600
const FRICTION = 550

var input = Vector2.ZERO

signal JustPress()
signal JustRelease()

@onready var hand_sprite = $HoldingHandPngClipart
@export var grabbing = false

var hand_open_texture = preload("res://Scenes/Hands/leftOpen.png")
var hand_closed_texture = preload("res://Scenes/Hands/leftClosed.png")

func _physics_process(delta):
	player_movement(delta)
	handle_grabs()
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()

func get_input():
	input.x = int(Input.is_action_pressed("move_right_l")) - int(Input.is_action_pressed("move_left_l"))
	input.y = int(Input.is_action_pressed("move_down_l")) - int(Input.is_action_pressed("move_up_l"))
	
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

func handle_grabs():
	#if !Global.handFlashing:
		if Input.is_action_just_pressed("grab_l"):
			JustPress.emit()
		elif Input.is_action_pressed("grab_l"):
			hand_sprite.texture = hand_closed_texture
			grabbing = true
		elif Input.is_action_just_released("grab_l"):
			JustRelease.emit()
			hand_sprite.texture = hand_open_texture
			grabbing = false
	#elif Global.handFlashing:
		#if grabbing:
			#JustRelease.emit()
			#hand_sprite.texture = hand_open_texture
		#grabbing = false
