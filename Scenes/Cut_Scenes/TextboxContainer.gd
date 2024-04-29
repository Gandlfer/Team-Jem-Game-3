extends MarginContainer

const CHAR_READ_RATE = 0.025

@onready var textbox_container = $TextboxContainer
@onready var label = $MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

var current_text = ""
var current_index = 0
var timer := Timer.new()

func _ready():
	#textbox_container = $TextboxContainer
	#label = textbox_container.find_node("MarginContainer/HBoxContainer/Label") as Label
	if textbox_container == null or label == null:
		print("Starting state: State.READY")
		hide_textbox()
		
	else:
		print("Textbox container or label not found.")
		
	queue_text("Hault Witch!")
	queue_text("You will not be escaping!....")
	queue_text("Unless you make me a potion that I want!")
	queue_text("But I'm not telling you what potion I want. HAHA ")
	# timer.connect("timeout",  , "_on_Timer_timeout")
func _process(_delta):
	if current_state == State.READING and current_index < current_text.length():
		label.text += current_text[current_index]
		current_index += 1

func queue_text(next_text):
	text_queue.push_back(next_text)

	if current_state == State.READY:
		display_text()

func hide_textbox():
	if $TextboxContainer != null:
		textbox_container.visible(false)

func show_textbox():
	if $TextboxContainer != null:
		textbox_container.visible(true)

func display_text():
	if text_queue.size() > 0:
		current_text = text_queue.pop_front()
		current_index = 0
		current_state = State.READING
		show_textbox()
		timer.start(CHAR_READ_RATE)
	
func _on_Timer_timeout():
	if current_index < current_text.length():
		# Add the next character to the label
		label.append_text(current_text[current_index])
		current_index += 1
	else:
		# Stop the timer when all text is displayed
		$Timer.stop()
		current_state = State.READY
		if text_queue.size() > 0:
			display_text()
