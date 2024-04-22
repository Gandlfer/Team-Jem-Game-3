extends Control

@export var collided = false
var outofbound = false
var blocked = false
var dropable = false
var pieces = false

var collidedPiecesList = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(!outofbound," ", !blocked ," ", dropable)
	if collidedPiecesList.size()>0:
		collided = false and dropable #and !pieces
	else:
		collided = true and dropable #and !pieces
	#collided = !outofbound and !blocked and dropable and !pieces
	#print(collidedPiecesList.size())
	#if collided == true:
		#print(collided)
	pass


func _on_area_2d_body_entered(body):
	#print(get_child(0))
	#print(body)
	#print(get_child(0)==body)
	if body.is_in_group("PuzzlePiece") and !(get_child(0)==body):
		#print("Something")
		#print("PuzzlePiece ",body.get_node("../Label").text,body.get_node("../../..").name)
		#collidedPiecesList[body.get_node("../../..").name] = ""
		#print(collidedPiecesList)
		pieces = true
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("PuzzlePiece") and !(get_child(0)==body):
		#print("Exit PuzzlePiece ",body.get_node("../Label").text,body.get_node("../../..").name)
		#collidedPiecesList.erase(body.get_node("../../..").name)
		#print(collidedPiecesList)
		pieces = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("OutofBounds"):
		#print("OutofBounds ",area.name)
		collidedPiecesList[area.name] = ""
		outofbound = true
	if area.is_in_group("BlockedBox"):
		#print("BlockedBox ",area.get_node("../../Label").text)
		collidedPiecesList[area.get_node("../../Label").text] = ""
		blocked = true
	if area.is_in_group("Dropable"):
		#print("Dropable ",area.get_node("..").name)
		dropable = true
		#print("In")

func _on_area_2d_area_exited(area):
	if area.is_in_group("Dropable"):
		#print("Out")
		dropable = false
	if area.is_in_group("BlockedBox"):
		collidedPiecesList.erase(area.get_node("../../Label").text)
		blocked = false
	if area.is_in_group("OutofBounds"):
		collidedPiecesList.erase(area.name)
		outofbound = false
		#print("Here")

