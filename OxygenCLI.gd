extends Label


onready var player: KinematicBody2D = $"../../Player"
onready var ship: Node2D = $"../../Ship"
onready var shipExchange: Area2D = $"../../Ship/ExchangeDetector"
onready var shipConnectionRange: Area2D = $"../../Ship/ConnectionDetector"

func _process(delta):
	var exchanging = shipExchange.overlaps_body(player)
	var connected = shipConnectionRange.overlaps_body(player)
	var player_oxygen = player.player_oxygen
	var ship_oxygen = ship.oxygen
	self.text = "> oxygen: " + _percentage(player_oxygen)

	if connected:
		self.text += "\n> pod oxygen: " + _percentage((ship_oxygen / 50) * 100)
	else:
		self.text += "\n> pod oxygen: connection lost"

	if exchanging:
		self.text += "\n> transferring oxygen"

func _percentage(value):
	return String(int(value)) + "%"

