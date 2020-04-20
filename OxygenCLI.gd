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

	self.text = "> drone oxygen: " + String(int(player.player_oxygen)) + "/" + String(int(player.max_oxygen()))

	if player.can_use_burst():
		if player.player_oxygen <= player.BURST_OXYGEN_USAGE + 10:
			self.text += "\n> o2 burst: not enough oxygen"
		elif player.burst_cooldown > 1:
			self.text += "\n> o2 burst: charging"
		else:
			self.text += "\n> o2 burst: ready (spacebar)"

	self.text += "\n> pod oxygen: " + String(int(ship.oxygen)) + "/" + String(int(ship.MAX_OXYGEN))
	self.text += "\n> pod parts: " + String(ship.item_count) + "/" + String(ship.MISSING_ITEMS)

	if exchanging:
		self.text += "\n> transferring oxygen"
	
	if player.has_item:
		self.text += "\n> cargo: pod fragment"


	if connected:
		if ship.oxygen < 20 and ship.oxygen > 5:
			self.text += "\n\nWARNING: pod oxygen low, return to pod"
		elif ship.oxygen <= 5:
			self.text += "\n\nWARNING: pod oxygen critical, return to pod"

	if player.player_oxygen < 20 and player.player_oxygen > 5:
		self.text += "\n\nWARNING: ship oxygen low, return to surface"
	elif player.player_oxygen <= 5:
		self.text += "\n\nWARNING: ship oxygen critical, return to surface"

func _percentage(value):
	return String(int(value)) + "%"

