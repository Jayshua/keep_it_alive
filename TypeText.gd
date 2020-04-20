extends Label

onready var start = OS.get_ticks_msec()

func _process(delta):
	var ellapsed = OS.get_ticks_msec() - start
	self.visible_characters = int(float(ellapsed) / 10)

	if self.percent_visible < 1:
		$AudioStreamPlayer.play()

