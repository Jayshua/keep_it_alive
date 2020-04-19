extends KinematicBody2D

const FRICTION = 0.98
const ACCELERATION = 1
const MAX_MOVEMENT_SPEED = 40
const MAX_CURRENT_SPEED = 1000
const MAX_BURST_SPEED = 1000
const OXYGEN_USAGE = 0.01
const MAX_OXYGEN = 100
const TRANSFER_RATE = 0.15
const BURST_ACCELERATION = 100

var velocity = Vector2(0, 0)
var player_oxygen = 100
var has_item = false
var burst_cooldown = 0

var engine_sound = -30
var engine_sound_target = 0

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

	if Input.is_action_pressed("fire"):
		if player_oxygen > 40 and burst_cooldown < 1:
			player_oxygen -= 25
			burst_cooldown = 5
			$Explosion.frame = 0
			velocity += velocity.normalized() * BURST_ACCELERATION
			for blocker in get_tree().get_nodes_in_group("Blocker"):
				if blocker.position.distance_squared_to(self.position) < 400:
					blocker.queue_free()

	burst_cooldown -= 1 * delta

	var in_current = false
	for current in $DetectionArea.get_overlapping_areas():
		if (current as Area2D).get_collision_layer_bit(2):
			player_oxygen = clamp(player_oxygen + 1, 0, MAX_OXYGEN)
		elif (current as Area2D).get_collision_layer_bit(3):
			if current.get_parent().needs_oxygen():
				current.get_parent().give_oxygen(TRANSFER_RATE)
				player_oxygen -= TRANSFER_RATE
			
			if has_item:
				current.get_parent().give_item()
				has_item = false
		elif current.get_collision_layer_bit(1):
			in_current = true
			velocity += current.get_force_vector()
		elif current.get_collision_layer_bit(5):
			if not has_item:
				current.get_parent().queue_free()
				has_item = true

	var max_speed
	if in_current:
		max_speed = MAX_CURRENT_SPEED
	elif burst_cooldown > 3:
		max_speed = MAX_BURST_SPEED
	else:
		max_speed = MAX_MOVEMENT_SPEED

	if velocity.length() > max_speed:
		velocity *= 0.85

	self.move_and_slide(velocity)

	for index in range(0, self.get_slide_count()):
		var collision = self.get_slide_collision(index)
		print(collision.collider_velocity)
		if velocity.length() > 3:
			velocity = -velocity * 0.95
		if velocity.length() > 10:
			$CollisionSound.play_once()

	velocity *= FRICTION

	self.rotation = velocity.angle()

	if moving:
		player_oxygen -= OXYGEN_USAGE
		engine_sound_target = -27
	else:
		engine_sound_target = -35
	
	if engine_sound > engine_sound_target:
		engine_sound -= 0.5
	elif engine_sound < engine_sound_target:
		engine_sound += 1
	
	$RunningSound.volume_db = engine_sound


























