extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(".").visible = false
	#transition()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.roundEnd:
		get_node(".").visible = true
		transitionToBlack()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
		
		Global.roundEnd = false

func transitionToBlack():
	$AnimationPlayer.play("fade_to_black")
	#print("Fade to black")
	
func transitionToNormal():
	$AnimationPlayer.play("fade_to_normal")
	
