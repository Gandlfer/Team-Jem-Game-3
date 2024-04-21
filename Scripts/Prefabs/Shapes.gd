extends Node2D

var draggable = false
var hovering = false
var is_inside_dropable = false
var body_ref
var initialPos: Vector2
var itemPos : Vector2
var list = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	initialPos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	blockIn()
	
	if draggable:
		
		if Input.is_action_just_pressed("left_mouse_click"):
			#initialPos = global_position
			pass
			Global.is_dragging = true
		if Input.is_action_pressed("left_mouse_click"):
			#print("Pressed")
			#print(global_position, " ",get_global_mouse_position())
			itemPos = get_global_mouse_position()
			#itemPos = Vector2(snapped(mouse_pos.x,158),snapped(mouse_pos.y,158))
			global_position = itemPos
			if hovering:
				if Input.is_action_just_pressed("right_mouse_click"):
					rotation_degrees=rotation_degrees+90
		elif Input.is_action_just_released("left_mouse_click"):
			#print("Released")
			#var mouse_pos : Vector2 = get_global_mouse_position()
			if is_inside_dropable:
				#getClosest()
				#global_position = itemPos
				global_position = getClosest()
			else:
				global_position = initialPos
				queue_free()
			Global.is_dragging = false
			Global.needAdd = true
			Global.node = get_groups()[0]
			#print(self.name)
			#var tween = get_tree().create_tween()
			#if is_inside_dropable:
				#tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			#else:
				#tween.tween_property(self,"global_position",Vector2(snapped(mouse_pos.x,83),snapped(mouse_pos.y,83)),0.2).set_ease(Tween.EASE_OUT)
	

func getClosest():
	var smallest_dict = 0
	var dist = 100000.0
	for x in list.keys():
		var calcDist=global_position.distance_to(Vector2(list[x].global_position.x + 37.5,list[x].global_position.y + 37.5))
		if dist > calcDist:
			smallest_dict = x
			dist = calcDist
		#global_position.distance_to()
		#print(list[x].global_position.x - 37.5)
		#print(global_position.distance_to(Vector2(list[x].global_position.x - 37.5,list[x].global_position.y - 37.5)))
		pass
	#print(list[smallest_dict].get_node("../Label").text)
	return Vector2(list[smallest_dict].global_position.x + 37.5,list[smallest_dict].global_position.y + 37.5)
	
func blockIn():
	var inside = true
	#get_child(0)
	for x in get_child(0).get_children():
			#print(x.name)
			if "PuzzlePiece" in x.name:
				inside = inside and x.collided
				#if !x.collided:
					#is_inside_dropable=false
	#print(inside)
	is_inside_dropable=inside
	#print("Block ",is_inside_dropable)
		
func _on_area_2d_body_entered(body):
	#print("From Z shape ",body.name)
	#var inside = true
	if body.is_in_group('Dropable'):
		#print("From L shape ",body.name,body.get_node("../Label").text)
		list[body.get_node("../Label").text]=body
		#print(list.keys())
		#list.append(body)
		##print("Collided")
		#for x in $L.get_children():
			##print(x.name)
			#if "PuzzlePiece" in x.name:
				#if !x.collided:
					#inside=false
	#if inside:
		#is_inside_dropable=true
	#else:
		#is_inside_dropable = false



func _on_area_2d_body_exited(body):
	if body.is_in_group('Dropable'):
		#print("Exit from L shape ",body.name,body.get_node("../Label").text)
		list.erase(body.get_node("../Label").text)
	pass # Replace with function body.


func _on_area_2d_mouse_entered():
	#if not Global.is_dragging:
	#print("Mouse inside")
	if not Global.is_dragging:
		draggable = true
		hovering = true
		
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	#print("Mouse Left")
	if not Global.is_dragging:
	#print("Mouse left")
		draggable = false
		hovering = false
		#Global.is_dragging = false
		#print("Mouse Left")
	pass # Replace with function body.
