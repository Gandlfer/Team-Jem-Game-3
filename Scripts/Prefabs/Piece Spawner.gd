extends Control

var Z_Node = preload("res://Scenes/Prefabs/Shapes/Z_Shape.tscn")
var Z_pos : Vector2
var T_Node = preload("res://Scenes/Prefabs/Shapes/t_shape.tscn")
var T_pos : Vector2
var I_Node = preload("res://Scenes/Prefabs/Shapes/I_Shape.tscn")
var I_pos : Vector2
var L_Node = preload("res://Scenes/Prefabs/Shapes/L_Shape.tscn")
var L_pos : Vector2
var Square_Node = preload("res://Scenes/Prefabs/Shapes/square_shape.tscn")
var Square_pos : Vector2
var Filler_Node = preload("res://Scenes/Prefabs/Shapes/FillerShape.tscn")
var Filler_pos : Vector2
var tmp : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Z_pos = $ZShape.position
	T_pos = $TShape.position
	I_pos = $IShape.position
	L_pos = $LShape.position
	Square_pos = $Square_shape.position
	Filler_pos = $FillerShape.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.needAdd:
		Global.needAdd = false
		#print(Global.node)
		spawner()

func spawner():
	match Global.node:
		"ZShape":
			tmp = Z_Node.instantiate()
			tmp.position = Z_pos
		"LShape":
			tmp = L_Node.instantiate()
			tmp.position = L_pos
		"IShape":
			tmp = I_Node.instantiate()
			tmp.position = I_pos
		"TShape":
			tmp = T_Node.instantiate()
			tmp.position = T_pos
		"Square_shape":
			tmp = Square_Node.instantiate()
			tmp.position = Square_pos
		"FillerShape":
			tmp = Filler_Node.instantiate()
			tmp.position = Filler_pos
	add_child(tmp)
	
