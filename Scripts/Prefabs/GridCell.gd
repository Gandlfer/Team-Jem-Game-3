extends Node2D

var cell = preload("res://Scenes/Prefabs/Cell.tscn")
var rng = RandomNumberGenerator.new()
var bgMusicPlayer : AudioStreamPlayer
var bgMusic : AudioStreamMP3 

# Called when the node enters the scene tree for the first time.
func _ready():
	#var temp = []
	#temp.remove_at()
	bgMusic = load("res://Audio/cotton-candy-children-puzzle-game-music-197733.mp3")
	bgMusicPlayer = AudioStreamPlayer.new()  # Create a new AudioStreamPlayer for the background music
	bgMusic.loop = true  # Set loop to true for the background music
	bgMusicPlayer.stream = bgMusic
	bgMusicPlayer.volume_db = -25
	add_child(bgMusicPlayer)
	bgMusicPlayer.play()
	
	
	var numbers = {}
	var arr = []
	for x in range(0,36):
		numbers[x]=""
		#numbers.append(x)

	for x in range (0,Global.level):
		#print(len(numbers.keys()))
		var randNum = rng.randi_range(0,len(numbers.keys())-1)
		#print(numbers.keys())
		arr.append(numbers.keys()[randNum])
		removeAround(numbers.keys()[randNum],numbers)
		#arr[x] = numbers[randNum]
		#numbers.erase(randNum)
		#numbers.remove_at(randNum)
			
	for x in range(0,36):
		var node = cell.instantiate()
		node.num=x
		#node.get_node("Label").visible = false
		if x in arr:#x == 7 or x == 21 or x == 30:#
			node.get_node("GridCellBody/Area2DCell").add_to_group("BlockedBox")
			node.get_node("GridCellBody/Area2DCell/Blocked").visible = true
		#print(x)
		$GridContainer.add_child(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func removeAround(x : int, dict):
	var positions= [[-7,-6,-5],[-1,0,+1],[5,6,7]]
	for arr in positions:
		for y in arr:
			dict.erase(x+y)
			
	#var row
	#var col
	#if x/6==0:
		#row = 0
	#elif x/6 == 5:
		#row = 2
	#if x%6 == 0: #first from the left
		#col = 0
		##pass
	#elif x%6 ==5: #first from the right
		#col = 3
		#pass
	#for x 
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("PuzzlePiece"):
		print("Entered")
	pass # Replace with function body.

