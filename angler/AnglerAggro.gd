extends Area2D

onready var angler = get_node("..")
export var target: Vector2
var start

func _ready():
	start = angler.get_position()
	target = start

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			target = body.get_position()
