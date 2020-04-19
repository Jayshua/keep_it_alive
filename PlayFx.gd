extends AudioStreamPlayer

export(float) var min_volume
export(float) var max_volume

func play_once(volume):
	volume = clamp(volume, 0, 1)
	if not playing:
		self.volume_db = ((max_volume - min_volume) * volume) + min_volume
		print(volume)
		self.play(0)
