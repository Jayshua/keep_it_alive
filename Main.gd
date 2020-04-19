extends Node2D

onready var player = $Player
onready var ship = $Ship
onready var shipConnectionDetector = $"Ship/ConnectionDetector"

func _process(delta):
	if player.player_oxygen <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")
	
	if ship.oxygen <= 0 && shipConnectionDetector.overlaps_body(player):
		get_tree().change_scene("res://scenes/GameOver.tscn")
