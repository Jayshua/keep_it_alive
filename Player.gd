extends KinematicBody2D

const FRICTION = 0.98
const ACCELERATION = 1
const MAX_MOVEMENT_SPEED = 40
const MAX_CURRENT_SPEED = 1000
const OXYGEN_USAGE = 0.01
const MAX_OXYGEN = 100
const TRANSFER_RATE = 0.15

var velocity = Vector2(0, 0)
var player_oxygen = 100


func _physics_process(delta):
	var moving = false

	if Input.is_action_pressed("move_down"):
		moving = true
		velocity += Vector2.DOWN * ACCELERATION

	if Input.is_action_pressed("move_up"):
		moving = true
		velocity += Vector2.UP * ACCELERATION

	if Input.is_action_pressed("move_left"):
		moving = true
		velocity += Vector2.LEFT * ACCELERATION

	if Input.is_action_pressed("move_right"):
		moving = true
		velocity += Vector2.RIGHT * ACCELERATION

	var in_current = false
	for current in $DetectionArea.get_overlapping_areas():
		if (current as Area2D).get_collision_layer_bit(2):
			player_oxygen = clamp(player_oxygen + 1, 0, MAX_OXYGEN)
		elif (current as Area2D).get_collision_layer_bit(3):
			if current.get_parent().needs_oxygen():
				current.get_parent().give_oxygen(TRANSFER_RATE)
				player_oxygen -= TRANSFER_RATE
		elif current.get_collision_layer_bit(1):
			in_current = true
			velocity += current.get_force_vector()
		elif current.get_collision_layer_bit(4):
			print("Take")

	if velocity.length() > (MAX_CURRENT_SPEED if in_current else MAX_MOVEMENT_SPEED):
		velocity *= 0.85

	velocity *= FRICTION

	self.move_and_slide(velocity)

	self.rotation = velocity.angle()

	if moving:
		player_oxygen -= OXYGEN_USAGE


























