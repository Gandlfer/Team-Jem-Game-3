extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text=str(int($Timer.time_left),"s")


func _on_timer_timeout():
	Global.roundEnd = true
	Global.level=3
