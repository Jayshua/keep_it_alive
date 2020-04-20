extends Area2D

func _ready():
	connect("body_entered", self, "entered")

func entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")
