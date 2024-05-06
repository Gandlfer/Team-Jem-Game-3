extends Node2D

var draggable = false
var hovering = false
var is_inside_dropable = false
var body_ref
var initialPos: Vector2
var itemPos : Vector2
var list = {}
var collidedPiecesList = {}
var dropSound
var pickupSound
var audioPlayer : AudioStreamPlayer
var handsIn= {}
var justpress = false
var grabjustpress = false
var justrelease = false
var placed = false

var customScale = 1.2

# Called when the node enters the scene tree for the first time.
func _ready():
	dropSound = preload("res://Audio/piece_interact.wav")
	pickupSound = preload("res://Audio/piece_interact.wav")
	audioPlayer = AudioStreamPlayer.new()
	add_child(audioPlayer)
	initialPos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	blockIn()
	#for x in handsIn.keys():
		#print(handsIn[x].position)
	if len(handsIn.keys()) >0:
		if draggable:
			if grabjustpress and Global.holdingPiece == null: #and handsIn["Grab"]==Global.detectedGrabPiece[len(Global.detectedGrabPiece.keys())-1]:
				#print(handsIn["Grab"])
				audioPlayer.stream = pickupSound
				audioPlayer.volume_db = -15  # Lower the volume
				audioPlayer.play()
				Global.is_dragging = true
				Global.holdingPiece = get_node(".")
				#Global.is_grabbing = true
				#Global.detectedGrab = true
			if handsIn["Grab"].grabbing and grabjustpress and Global.holdingPiece == get_node("."):
				Global.is_dragging = true
				#Global.holdingPiece = get_node(".")
				#print(get_node("."))
				#Global.is_grabbing = true
				#print("Here")
				global_position =  handsIn["Grab"].get_node("GrabArea/GrabCollisionShape").global_position
				if hovering:
					if justpress:
						justpress = false
						#print("Rotating")
						rotation_degrees=rotation_degrees+90
						if rotation_degrees == 360:
							rotation_degrees = 0
				#pass
			elif justrelease:
				#print("Here")
				justrelease = false
				#grabjustpress = false
				if is_inside_dropable and collidedPiecesList.size()==0 and placed:
					#print("True")
					audioPlayer.stream = dropSound
					audioPlayer.volume_db = 0.5  # Lower the volume
					audioPlayer.play()
					global_position = getClosest()
					Global.piecesInside[get_node(".").get_groups()[0]][get_node(".").name]=""
					#placed = true
				elif is_inside_dropable and collidedPiecesList.size()==0:
					#print("True")
					audioPlayer.stream = dropSound
					audioPlayer.volume_db = 0.5  # Lower the volume
					audioPlayer.play()
					global_position = getClosest()
					Global.piecesInside[get_node(".").get_groups()[0]][get_node(".").name]=""
					Global.needAdd = true
					Global.node = get_groups()[0]
					placed = true
				elif placed:
					global_position = initialPos
					Global.piecesInside[get_node(".").get_groups()[0]].erase(get_node(".").name)
					queue_free()
					
				else:
					#print("False")
					#print(is_inside_dropable)
					#print(collidedPiecesList.size())
					global_position = initialPos
					Global.piecesInside[get_node(".").get_groups()[0]].erase(get_node(".").name)
					Global.needAdd = true
					Global.node = get_groups()[0]
					queue_free()
				Global.is_dragging = false
				Global.holdingPiece = null
				#Global.is_grabbing = false
				#Global.needAdd = true
				#Global.node = get_groups()[0]
				#placed = true
	if justpress:
		justpress = false

			#pass
		#if Input.is_action_just_pressed("left_mouse_click"):
			##initialPos = global_position
			##pass
			#audioPlayer.stream = pickupSound
			#audioPlayer.volume_db = -15  # Lower the volume
			#audioPlayer.play()
			#Global.is_dragging = true
		#if Input.is_action_pressed("left_mouse_click"):
			#Global.is_dragging = true
			##print("Pressed on ",get_node(".").get_groups()[0])
			##print(global_position, " ",get_global_mouse_position())
			#itemPos = get_global_mouse_position()
			##print("Clicking")
			##itemPos = Vector2(snapped(mouse_pos.x,158),snapped(mouse_pos.y,158))
			#global_position = itemPos
			#if hovering:
				#if Input.is_action_just_pressed("right_mouse_click"):
					#rotation_degrees=rotation_degrees+90
					#if rotation_degrees == 360:
						#rotation_degrees = 0
		#elif Input.is_action_just_released("left_mouse_click"):
			##print("Released")
			##var mouse_pos : Vector2 = get_global_mouse_position()
			#if is_inside_dropable and collidedPiecesList.size()==0:
				#audioPlayer.stream = dropSound
				#audioPlayer.volume_db = 0.5  # Lower the volume
				#audioPlayer.play()
				##getClosest()
				##global_position = itemPos
				#global_position = getClosest()
				#Global.piecesInside[get_node(".").get_groups()[0]][get_node(".").name]=""
				##print(Global.piecesInside)
				##print(get_node(".").get_groups()[0])
				##Global.piecesInside[]
			#else:
				#global_position = initialPos
				#Global.piecesInside[get_node(".").get_groups()[0]].erase(get_node(".").name)
				##print(Global.piecesInside)
				#queue_free()
			#Global.is_dragging = false
			#Global.needAdd = true
			#Global.node = get_groups()[0]
			#print(self.name)
			#var tween = get_tree().create_tween()
			#if is_inside_dropable:
				#tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			#else:
				#tween.tween_property(self,"global_position",Vector2(snapped(mouse_pos.x,83),snapped(mouse_pos.y,83)),0.2).set_ease(Tween.EASE_OUT)


func getClosest():
	var smallest_dict = 0
	var dist = 100000.0
	var x_offset = 0
	var y_offset = 0
	for x in list.keys():
		#print(rotation_degrees)
		var calcDist=global_position.distance_to(Vector2(list[x].global_position.x + 37.5,list[x].global_position.y + 37.5))
		if dist > calcDist:
			smallest_dict = x
			dist = calcDist

	if rotation_degrees == 0:
		x_offset = -1
		y_offset = -1
	elif rotation_degrees == 90:
		x_offset = 2
		y_offset = -1
	elif rotation_degrees == 180:
		x_offset = 2.5
		y_offset = 3.5
	elif rotation_degrees == 270:
		x_offset = -2.5
		y_offset = 3.5
	return Vector2(list[smallest_dict].global_position.x + (37.5+x_offset)*customScale,list[smallest_dict].global_position.y + (37.5+y_offset)*customScale)
	
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
		#print("Entering ",body.name,body.get_node("../Label").text)
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
		#print("Exit ",body.name,body.get_node("../Label").text)
		list.erase(body.get_node("../Label").text)
	pass # Replace with function body.


func _on_area_2d_mouse_entered():
	#if not Global.is_dragging:
	
	#if not Global.is_dragging:
		#print("Mouse inside")
		#draggable = true
		#hovering = true
		
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	#print("Mouse Left")
	#if not Global.is_dragging:
		#print("Mouse left")
		#draggable = false
		#hovering = false
		#Global.is_dragging = false
		#print("Mouse Left")
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	#if not Global.is_dragging:
		#print("Mouse inside")
		#draggable = true
		#hovering = true
	if area.is_in_group("Hands"):
		#print("Hand in")
		#print(area.get_node(".."))
		
			if len(handsIn.keys())==0:
				if not Global.is_dragging and not Global.detectPiece:
					Global.detectPiece = true
					#if(Global.)
					#Global.detectedGrabPiece[len(Global.detectedGrabPiece.keys())]=area.get_node("..")
					#print("Adding detectedGrab ", Global.detectedGrabPiece)
					#GLoba
					handsIn["Grab"]=area.get_node("..")
					handsIn["Grab"].JustPress.connect(GrabJustPressHandler)
					handsIn["Grab"].JustRelease.connect(JustReleaseHandler)
					draggable = true
				#print("Grab is ", handsIn["Grab"])
			elif len(handsIn.keys())==1 and handsIn.find_key(area.get_node(".."))!="Grab":
				handsIn["Rotate"]=area.get_node("..")
				handsIn["Rotate"].JustPress.connect(JustPressHandler)
				#area.get_node("..").JustRelease.connect(JustReleaseHandler)
				#print("Here")
				hovering = true
			#print("Grab is ", handsIn["Grab"], " Rotate is ",handsIn["Rotate"])
		#print(handsIn.find_key(area.get_node("..")))
		#print("Grab is ", handsIn["Grab"], " Rotate is ",handsIn["Rotate"])
	else:
	#if 
	#print(area.get_groups())
	#print("Entering from ",get_node(".").name," to ", area.get_node("../..").name)
		#print("Entering ",area.get_node("../..").name)
		#print(area.get_node("../..").name)
		collidedPiecesList[area.get_node("../..").name] = ""
	#pass # Replace with function body.


func _on_area_2d_area_exited(area):
	
	if area.is_in_group("Hands"):
		#print("Hand out")
		if not Global.is_dragging:
		#handsIn.erase(area.get_groups()[1])
			#print(handsIn.find_key(area.get_node("..")))
			if handsIn.find_key(area.get_node("..")) == "Grab":
				if len(handsIn.keys())==2:
					#print("Before swap", handsIn["Grab"].name)
					handsIn["Grab"].JustPress.disconnect(GrabJustPressHandler)
					handsIn["Grab"].JustRelease.disconnect(JustReleaseHandler)
					handsIn["Rotate"].JustPress.disconnect(JustPressHandler)
					#Global.detectedGrabPiece[Global.detectedGrabPiece.find_key(handsIn["Grab"])]=handsIn["Rotate"]
					handsIn["Grab"]=handsIn["Rotate"]
					
					handsIn["Grab"].JustPress.connect(GrabJustPressHandler)
					handsIn["Grab"].JustRelease.connect(JustReleaseHandler)
					hovering = false
					#print("Hands swap")
					#print(handsIn["Grab"].name)
					#Global.detectedGrabPiece[len(Global.detectedGrabPiece.key())]=area.get_node("..")
					handsIn.erase("Rotate")
				else:
					handsIn["Grab"].JustPress.disconnect(GrabJustPressHandler)
					handsIn["Grab"].JustRelease.disconnect(JustReleaseHandler)
					#print("Removing detectedGrab ", Global.detectedGrabPiece)
					#if len(Global.detectedGrabPiece.keys())==2 and Global.detectedGrabPiece.find_key(handsIn["Grab"])==0:
						#print("Removing 0 ",Global.detectedGrabPiece[0])
						#Global.detectedGrabPiece[0]=Global.detectedGrabPiece[1]
						#Global.detectedGrabPiece.erase(1)
						#print("Result of swap ", Global.detectedGrabPiece)
					#else:
						#print("Removing ",Global.detectedGrabPiece[Global.detectedGrabPiece.find_key(handsIn["Grab"])])
						#Global.detectedGrabPiece.erase(Global.detectedGrabPiece.find_key(handsIn["Grab"]))
						#print("Removing detectedGrab ", Global.detectedGrabPiece)
					#Global.detectedGrabPiece[len(Global.detectedGrabPiece.key())]=handsIn["Grab"]
					handsIn.erase("Grab")
					Global.detectPiece = false
					draggable = false
				#grabjustpress = false
			elif handsIn.find_key(area.get_node("..")) == "Rotate":
				#print("Rotate")
				handsIn["Rotate"].JustPress.disconnect(JustPressHandler)
				handsIn.erase("Rotate")
				justrelease = false
				hovering = false
		if Global.is_dragging:
			#if handsIn.find_key(area.get_node("..")) == "Grab":
				#print("Removing 0 ",Global.detectedGrabPiece[0])
				#Global.detectedGrabPiece[0]=Global.detectedGrabPiece[1]
				#Global.detectedGrabPiece.erase(1)
				#print("Result of swap ", Global.detectedGrabPiece)
			#if handsIn.find_key(area.get_node("..")) == "Grab":
				#print("Here")
				#handsIn["Grab"].JustPress.disconnect(GrabJustPressHandler)
				#handsIn["Grab"].JustRelease.disconnect(JustReleaseHandler)
				#handsIn.erase("Grab")
			if handsIn.find_key(area.get_node("..")) == "Rotate":
				#print("Rotate")
				handsIn["Rotate"].JustPress.disconnect(JustPressHandler)
				handsIn.erase("Rotate")
				justrelease = false
				hovering = false
		#print(justrelease)
	else:
		#print("Exiting from ",get_node(".").name," to ",area.get_node("../..").name)
		collidedPiecesList.erase(area.get_node("../..").name)

func JustPressHandler():
	#print("Activated")
	justpress = true
func JustReleaseHandler():
	justrelease = true
	grabjustpress = false
func GrabJustPressHandler():
	grabjustpress = true
