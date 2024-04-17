extends Control

@export var collided = false
var outofbound = false
var blocked = false
var dropable = false
var pieces = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(!outofbound," ", !blocked ," ", dropable)
	collided = !outofbound and !blocked and dropable and !pieces
	if collided == true:
		print(collided)
	pass


func _on_area_2d_body_entered(body):
	#print(get_child(0))
	#print(body)
	#print(get_child(0)==body)
	if body.is_in_group("PuzzlePiece") and !(get_child(0)==body):
		pieces = true
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("PuzzlePiece") and !(get_child(0)==body):
		pieces = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("OutofBounds"):
		outofbound = true
	if area.is_in_group("BlockedBox"):
		blocked = true
	if area.is_in_group("Dropable"):
		dropable = true
		print("In")

func _on_area_2d_area_exited(area):
	if area.is_in_group("Dropable"):
		print("Out")
		dropable = false
	if area.is_in_group("BlockedBox"):
		blocked = false
	if area.is_in_group("OutofBounds"):
		outofbound = false
		#print("Here")

