tool
extends Area2D

export(float) var forceRotation
export(float) var forceMagnitude

onready var particles = $Particles2D
onready var collision_shape = $CollisionShape2D

func _ready():
	var particles = $Particles2D
	var extents = $CollisionShape2D.shape.extents
	particles.emission_rect_extents = extents
	particles.direction = Vector2(cos(forceRotation), sin(forceRotation))
	particles.angle = rad2deg(forceRotation)

func _process(delta):
	if Engine.editor_hint:
		if collision_shape:
			particles.emission_rect_extents = collision_shape.shape.extents
			particles.direction = Vector2(cos(forceRotation), sin(forceRotation))
			particles.angle = rad2deg(forceRotation)
		else:
			print("False")


func get_force_vector():
	var offset = sin(float(Engine.get_physics_frames()) / TAU)
	return Vector2(cos(forceRotation + offset) * forceMagnitude, sin(forceRotation) * forceMagnitude)

#func _ready():
#	self.connect("area_entered", self, "handle_enter")

#func handle_enter(body):
#	print("Here")
