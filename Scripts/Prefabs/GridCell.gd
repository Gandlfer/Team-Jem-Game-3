extends Node2D

var cell = preload("res://Scenes/Prefabs/Cell.tscn")
var rng = RandomNumberGenerator.new()
var arr = [-1,-1,-1]
# Called when the node enters the scene tree for the first time.
func _ready():
	var numbers = []
	for x in range(0,36):
		numbers.append(x)

	for x in range (0,3):
		var randNum = rng.randi_range(0,numbers.size()-1)
		arr[x] = numbers[randNum]
		numbers.remove_at(randNum)
			
	for x in range(0,36):
		var node = cell.instantiate()
		node.num=x
		if x in arr:#x == 7 or x == 21 or x == 30:#
			node.get_node("GridCellBody/Area2DCell").add_to_group("BlockedBox")
			node.get_node("GridCellBody/Area2DCell/Blocked").visible = true
		#print(x)
		$GridContainer.add_child(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("PuzzlePiece"):
		print("Entered")
	pass # Replace with function body.
