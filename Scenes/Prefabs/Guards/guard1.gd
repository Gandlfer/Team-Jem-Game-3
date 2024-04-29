extends CharacterBody2D

var animationPlayer : AnimationPlayer

func _ready():
	# Get the AnimationPlayer node (assuming it's a child node named "AnimationPlayer")
	animationPlayer = $AnimationPlayer
	
	# Play the animation when the scene starts
	animationPlayer.play("idle")
