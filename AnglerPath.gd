extends Path2D

onready var follow = get_node("PathFollow2D")
export var speed: float = 10.0;

func _ready():
	set_process(true)

func _process(delta):
	follow.set_offset(follow.get_offset() + speed * delta)
