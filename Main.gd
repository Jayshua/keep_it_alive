extends Node2D

onready var player = $Player
onready var ship = $Ship

func _process(delta):
	if player.player_oxygen <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")
	
	#if ship.oxygen <= 0 && ship.get_indexed("ConnectionDetector").overlaps_body(player):
	#	get_tree().change_scene("res://scenes/GameOver.tscn")
