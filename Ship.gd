extends Node2D

const MAX_OXYGEN = 50
const LEAK_RATE = 1

signal player_connection_change(is_connected)
signal player_exchange_range(is_in_range)
signal oxygen_change(amount)

var oxygen = MAX_OXYGEN

func _process(delta):
	_apply_oxygen(LEAK_RATE * delta)

func needs_oxygen():
	return abs(oxygen - MAX_OXYGEN) >= 0.1

func give_oxygen(amount):
	_apply_oxygen(-amount)

func get_oxygen():
	return oxygen

func _apply_oxygen(amount):
	oxygen -= amount
	emit_signal("oxygen_change", oxygen)

func _on_ConnectionDetector_body_entered(body):
	emit_signal("player_connection_change", true)

func _on_ConnectionDetector_body_exited(body):
	emit_signal("player_connection_change", false)


func _on_ExchangeDetector_body_entered(body):
	emit_signal("player_exchange_range", true)


func _on_ExchangeDetector_body_exited(body):
	emit_signal("player_exchange_range", false)
