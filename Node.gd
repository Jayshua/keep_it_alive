extends Node

const PLAY_FREQUENCY = 60000
var unused_sounds
var last_played = OS.get_ticks_msec()
var current_sound = null
var queued_sounds = []

func _ready():
	shuffle_sounds()


func queue_sound(sound):
	if not queued_sounds.has(sound) and current_sound != sound:
		queued_sounds.push_back(sound)

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if current_sound and not current_sound.playing:
		current_sound = null

	if not current_sound and queued_sounds.size() > 0:
		current_sound = queued_sounds.pop_front()
		current_sound.play()
		last_played = OS.get_ticks_msec()
	else:
		if OS.get_ticks_msec() - last_played > PLAY_FREQUENCY:
			last_played = OS.get_ticks_msec()
			
			if unused_sounds.size() == 0:
				$Dave.play()
				shuffle_sounds()
			else:
				var sound = unused_sounds.pop_back()
				sound.play()


func shuffle_sounds():
	unused_sounds = $ShuffleSounds.get_children()
	unused_sounds.shuffle()
