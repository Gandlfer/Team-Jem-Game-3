extends CharacterBody2D

var startPosition
var targetPosition
var duration = 4.0
var timeElapsed = 0.0
var animationPlayer

func _ready():
	startPosition = position
	targetPosition = Vector2(750, position.y)  # Adjust 800 to the desired end position
	animationPlayer = $AnimationPlayer  # Assuming the AnimationPlayer is named "AnimationPlayer"

func _process(delta):
	timeElapsed += delta
	if timeElapsed <= duration:
		var t = timeElapsed / duration
		position.x = lerp(startPosition.x, targetPosition.x, t)
		animationPlayer.play("walk")  # Play the "walk" animation
	else:
		position = targetPosition
		animationPlayer.stop()  # Stop the animation when movement is complete

func lerp(start, end, weight):
	return start + (end - start) * weight


