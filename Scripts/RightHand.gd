extends CharacterBody2D

const MAX_SPEED = 500
const ACCELERATION = 800
const FRICTION = 1000

func _physics_process(delta):
	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("move_left_r", "move_right_r", "move_up_r", "move_down_r")
	velocity = input_direction * MAX_SPEED
