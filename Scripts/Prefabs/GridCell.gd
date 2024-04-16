extends Node2D

var cell = preload("res://Cell.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(0,36):
		var node = cell.instantiate()
		node.num=x
		print(x)
		$GridContainer.add_child(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$GridContainer.get_children()
	pass
