extends AudioStreamPlayer


func play_once():
	if not playing:
		self.play(0)
