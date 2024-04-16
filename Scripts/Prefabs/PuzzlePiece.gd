extends Control

@export var collided = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Dropable"):
		#print("turn true")
		#collided = true
		pass
		#print($PuzzlePieceBody/Area2D/CollisionShape2D.get_shape().)
		#print("Puzzle Piece: Collided with ", body.get_node("../Label").text)
		#print($PuzzlePieceBody/Area2D.get_overlapping_bodies())



func _on_area_2d_body_exited(body):
	if body.is_in_group("Dropable"):
		#print("turn false")
		pass
		#collided = false
		#print($PuzzlePieceBody/Area2D/CollisionShape2D.get_shape().)
		#print("Puzzle Piece: Left ", body.get_node("../Label").text)
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.is_in_group("Dropable"):
		collided = true
		#print("Here")



func _on_area_2d_area_exited(area):
	if area.is_in_group("Dropable"):
		collided = false
		#print("Here")

