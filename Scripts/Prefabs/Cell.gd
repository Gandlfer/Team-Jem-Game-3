extends Control

@export var num : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(num)
	pass


func _on_area_2d_body_entered(body):
	#print("From Cell ",body.name)
	if body.is_in_group("PuzzlePiece"):
		print($"Label".text," Collided with ", body.name)



func _on_area_2d_area_entered(area):
	#print(area.name)
	pass # Replace with function body.
