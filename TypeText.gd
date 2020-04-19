extends Label

onready var start = OS.get_ticks_msec()

func _process(delta):
	var ellapsed = OS.get_ticks_msec() - start
	print(ellapsed / 900)
	self.visible_characters = int(float(ellapsed) / 20)

