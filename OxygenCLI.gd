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

	if player.player_oxygen <= 30:
		self.text += "\n> o2 burst: not enough oxygen"
	elif player.burst_cooldown > 1:
		self.text += "\n> o2 burst: charging"
	else:
		self.text += "\n> o2 burst: ready"

	self.text += "\n> pod oxygen: " + _percentage((ship_oxygen / 50) * 100)
	self.text += "\n> pod status: " + String(ship.item_count) + "/" + String(ship.MISSING_ITEMS)

	if exchanging:
		self.text += "\n> transferring oxygen"
	
	if player.has_item:
		self.text += "\n> cargo: pod fragment"


	if connected:
		if ship.oxygen < 20 and ship.oxygen > 5:
			self.text += "\n\nWARNING: pod oxygen low"
		elif ship.oxygen <= 5:
			self.text += "\n\nWARNING: pod oxygen critical"

	if player.player_oxygen < 20 and player.player_oxygen > 5:
		self.text += "\n\nWARNING: ship oxygen low"
	elif player.player_oxygen <= 5:
		self.text += "\n\nWARNING: ship oxygen critical"

func _percentage(value):
	return String(int(value)) + "%"

