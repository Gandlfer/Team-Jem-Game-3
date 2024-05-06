extends AudioStreamPlayer

const main_menu_music = preload("res://Assets/spellcraft-142264.mp3")


func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(main_menu_music)

func stop_music():
	#stop()
	self.stream_paused = true
