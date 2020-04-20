extends Node2D

var MAX_OXYGEN = 50
const LEAK_RATE = 0.5
onready var MISSING_ITEMS = get_tree().get_nodes_in_group("Item").size()
export(NodePath) var sound_player_path
onready var sound_player = get_node(sound_player_path)


signal player_connection_change(is_connected)
signal player_exchange_range(is_in_range)
signal oxygen_change(amount)

var oxygen = 11 # MAX_OXYGEN
var item_count = 0
var played_death_sound = false
var unused_death_sounds = []


func shuffle_death_sounds():
	unused_death_sounds = $DeathSounds.get_children()
	unused_death_sounds.shuffle()


func _process(delta):
	_apply_oxygen(LEAK_RATE * delta)
	
	if low_oxygen() and not played_death_sound:
		played_death_sound = true
		
		if unused_death_sounds.size() == 0:
			shuffle_death_sounds()

		var sound = unused_death_sounds.pop_back()
		sound_player.queue_sound(sound)

func needs_oxygen():
	return abs(oxygen - MAX_OXYGEN) >= 0.1

func low_oxygen():
	return oxygen < 10

func give_oxygen(amount):
	_apply_oxygen(-amount)

func give_item():
	item_count += 1
	MAX_OXYGEN += 2

func get_oxygen():
	return oxygen

func _apply_oxygen(amount):
	oxygen -= amount
	emit_signal("oxygen_change", oxygen)

	if not low_oxygen():
		played_death_sound = false

func _on_ConnectionDetector_body_entered(body):
	emit_signal("player_connection_change", true)

func _on_ConnectionDetector_body_exited(body):
	emit_signal("player_connection_change", false)


func _on_ExchangeDetector_body_entered(body):
	emit_signal("player_exchange_range", true)


func _on_ExchangeDetector_body_exited(body):
	emit_signal("player_exchange_range", false)
