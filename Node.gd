extends Node

const PLAY_FREQUENCY = 25000
var unused_sounds
var last_played = OS.get_ticks_msec()
var current_sound = null
var queued_sounds = []
export(NodePath) var player_path
onready var player = get_node(player_path)


func _ready():
	shuffle_sounds()

func play_if_free(sound):
	if not current_sound:
		current_sound = sound
		sound.play()

func queue_sound(sound):
	if not queued_sounds.has(sound) and current_sound != sound:
		queued_sounds.push_back(sound)

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if current_sound and not current_sound.playing:
		current_sound = null
	print(player.position.y)
	if OS.get_ticks_msec() - last_played > PLAY_FREQUENCY and player.position.y < 338:
		if unused_sounds.size() == 0:
			queued_sounds.push_back($Dave)
			shuffle_sounds()
		else:
			queued_sounds.push_back(unused_sounds.pop_back())

	if not current_sound and queued_sounds.size() > 0:
		current_sound = queued_sounds.pop_front()
		current_sound.play()
		last_played = OS.get_ticks_msec()


func shuffle_sounds():
	unused_sounds = $ShuffleSounds.get_children()
	unused_sounds.shuffle()
