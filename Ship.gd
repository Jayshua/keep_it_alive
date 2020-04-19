extends Node2D

const MAX_OXYGEN = 50
const LEAK_RATE = 1

var oxygen = MAX_OXYGEN

func _process(delta):
	_apply_oxygen(LEAK_RATE * delta)

func needs_oxygen():
	return abs(oxygen - MAX_OXYGEN) >= 0.1

func give_oxygen(amount):
	_apply_oxygen(-amount)

func _apply_oxygen(amount):
	oxygen -= amount
	$TextureProgress2.value = oxygen
