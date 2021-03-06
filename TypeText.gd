extends Label

onready var start = OS.get_ticks_msec()
var signal_emitted = false

signal all_text_visible()

func _process(delta):
	var ellapsed = OS.get_ticks_msec() - start
	self.visible_characters = int(float(ellapsed) / 10)

	if self.percent_visible < 1:
		$AudioStreamPlayer.play()
	elif not signal_emitted:
		emit_signal("all_text_visible")
		signal_emitted = true

