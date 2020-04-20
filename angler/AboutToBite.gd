extends Area2D

onready var sprite = get_node("..")
onready var frame0Light = get_node("../Frame0")
onready var frame1Light = get_node("../Frame1")
onready var frame2Light = get_node("../Frame2")

func _ready():
	connect("body_entered", self, "entered")
	connect("body_exited", self, "exited")

func entered(body):
	if body.name == "Player":
		sprite.frame = 2
		frame0Light.enabled = false
		frame1Light.enabled = false
		frame2Light.enabled = true

func exited(body):
	if body.name == "Player":
		sprite.frame = 1
		frame0Light.enabled = false
		frame2Light.enabled = false
		frame1Light.enabled = true
