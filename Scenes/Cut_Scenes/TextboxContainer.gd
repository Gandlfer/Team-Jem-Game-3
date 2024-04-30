extends MarginContainer

const CHAR_READ_RATE = 0.025
const TEXT_DELAY = 3.0

@onready var textbox_container = $TextboxContainer
@onready var label = $MarginContainer/HBoxContainer/Label
var timer := Timer.new()
signal timeout

enum State {
	READY,
	READING,
	PAUSED,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var current_text = ""
var current_index = 0

func _ready():
	if textbox_container == null or label == null:
		print("Textbox container or label not found.")
		hide_textbox()
		queue_text("Hault Witch! You will not be escaping!.... You make me a potion that I want! But I'm not telling you what potion I want. HAHA ")

func _process(delta):
	# queue_text("Hault Witch! You will not be escaping!.... You make me a potion that I want! But I'm not telling you what potion I want. HAHA ")
	match current_state:
		State.READING:
			if current_index < current_text.length():
				label.text += current_text[current_index]
				current_index += 1
				timer.start(CHAR_READ_RATE)
			else:
				current_state = State.PAUSED
				timer.start(TEXT_DELAY)
		State.PAUSED:
			pass
		_:
			pass

func queue_text(next_text):
	text_queue.push_back(next_text)
	if current_state == State.READY:
		display_text()

func hide_textbox():
	if textbox_container != null:
		textbox_container.visible = false

func show_textbox():
	if textbox_container != null:
		textbox_container.visible = true

func display_text():
	if text_queue.size() > 0:
		current_text = text_queue.pop_front()
		current_index = 0
		current_state = State.READING
		show_textbox()
		timer.start(TEXT_DELAY) # Start the timer to delay displaying the next text
	else:
		current_state = State.FINISHED

func _on_Timer_timeout():
	match current_state:
		State.PAUSED:
			timer.stop()
			current_state = State.READY
			if text_queue.size() > 0:
				display_text()
		_:
			if current_index < current_text.length():
				label.append_text(current_text[current_index])
				current_index += 1
			else:
				timer.stop()
				current_state = State.READY
				if text_queue.size() > 0:
					display_text()
