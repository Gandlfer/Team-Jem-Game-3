extends Node2D
var ltor
var rtol
var max_distance = 1000
var threshold_distance = 100

# Colors for near and far distances
var near_color = Color(0, 1, 0) # Green
var middle_color = Color(1, 1, 0)  # Yellow
var far_color = Color(1, 0, 0)  # Red

var viewRect := get_viewport_rect()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate vector from left hand to right hand and store
	ltor = Vector2($"Right hand/RightHandParticles".global_position.x - $"Left hand/LeftHandParticles".global_position.x, $"Right hand/RightHandParticles".global_position.y - $"Left hand/LeftHandParticles".global_position.y)
	rtol = Vector2($"Left hand/LeftHandParticles".global_position.x - $"Right hand/RightHandParticles".global_position.x, $"Left hand/LeftHandParticles".global_position.y - $"Right hand/RightHandParticles".global_position.y)
	
	# Set Directions
	$"Left hand/LeftHandParticles".direction = ltor
	$"Right hand/RightHandParticles".direction = rtol
	
	# Set Speed
	$"Left hand/LeftHandParticles".initial_velocity_min = ltor.distance_to(rtol)
	$"Left hand/LeftHandParticles".initial_velocity_max = $"Left hand/LeftHandParticles".initial_velocity_min
	$"Right hand/RightHandParticles".initial_velocity_min = rtol.distance_to(ltor)
	$"Right hand/RightHandParticles".initial_velocity_max = $"Right hand/RightHandParticles".initial_velocity_min
	
	var particle_color
	if ltor.distance_to(rtol) < threshold_distance:
		particle_color = near_color
	else:
		# Map distance to a value between 0 and 1
		# Threshold distance is used to set the distance that it stays green while within
		var normalized_distance = clamp((ltor.distance_to(rtol) - threshold_distance) / (max_distance - threshold_distance), 0, 1)
		
		# Interpolate between near and far colors based on the normalized distance
		if normalized_distance <= 0.5:
			particle_color = near_color.lerp(middle_color, normalized_distance * 2)
		else:
			particle_color = middle_color.lerp(far_color, (normalized_distance - 0.5) * 2)
	
	# Set the color of the particles
	$"Left hand/LeftHandParticles".color = particle_color
	$"Right hand/RightHandParticles".color = particle_color
	
	$"Left hand".position.x = clamp($"Left hand".position.x, 0, 1920)
	$"Left hand".position.y = clamp($"Left hand".position.y, 0, 1920)
	
	$"Right hand".position.x = clamp($"Right hand".position.x, 0, 1080)
	$"Right hand".position.y = clamp($"Right hand".position.y, 0, 1080)
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
