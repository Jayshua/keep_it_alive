extends Node2D

func _process(delta):
	if $Player.get_oxygen() <= 0:
		get_tree().change_scene("res://GameOver.tscn")
