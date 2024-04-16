extends CenterContainer

var draggable = false
var is_inside_dropable = false
var body_ref
var initialPos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable:
		
		if Input.is_action_just_pressed("mouseclick"):
			initialPos = global_position
		if Input.is_action_pressed("mouseclick"):
			print("Pressed")
			print(global_position, " ",get_global_mouse_position())
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("mouseclick"):
			print("Released")
			#Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
	


func _on_area_2d_body_entered(body):
	if body.is_in_group('Dropable'):
		pass
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.


func _on_area_2d_mouse_entered():
	#if not Global.is_dragging:
	print("Mouse inside")
	draggable = true
		
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	#print("Mouse Left")
	#if not Global.is_dragging:
	print("Mouse left")
	draggable = false
		#Global.is_dragging = false
		#print("Mouse Left")
	pass # Replace with function body.
