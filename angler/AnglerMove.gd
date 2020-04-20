extends AnimatedSprite

onready var aggro = get_node("Aggro")
var speed = 0.5;

func _ready():
	set_process(true)
	
func _physics_process(delta):
	set_position(lerp(get_position(), aggro.target, speed * delta))
