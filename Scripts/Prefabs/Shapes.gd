extends Node2D

var draggable = false
var hovering = false
var is_inside_dropable = false
var body_ref
var initialPos: Vector2
var itemPos : Vector2

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
			
		elif Input.is_action_just_released("left_mouse_click"):
			#print("Released")
			#var mouse_pos : Vector2 = get_global_mouse_position()
			if is_inside_dropable:
				global_position = itemPos
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
	if hovering:
		if Input.is_action_just_pressed("right_mouse_click"):
			rotation_degrees=rotation_degrees+90


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
	pass
	#var inside = true
	#if body.is_in_group('Dropable'):
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
	pass # Replace with function body.


func _on_area_2d_mouse_entered():
	#if not Global.is_dragging:
	print("Mouse inside")
	if not Global.is_dragging:
		draggable = true
		hovering = true
		
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	print("Mouse Left")
	if not Global.is_dragging:
	#print("Mouse left")
		draggable = false
		hovering = false
		#Global.is_dragging = false
		#print("Mouse Left")
	pass # Replace with function body.
