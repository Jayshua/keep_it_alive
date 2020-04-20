extends KinematicBody2D

const FRICTION = 0.98
const ACCELERATION = 1
const MAX_MOVEMENT_SPEED = 40
const MAX_CURRENT_SPEED = 1000
const MAX_BURST_SPEED = 1000
const OXYGEN_USAGE = 0.01
const BASE_OXYGEN = 60
const TRANSFER_RATE = 0.15
const BURST_OXYGEN_USAGE = 30
const BURST_ACCELERATION = 100
const OXYGEN_TANK_SIZE = 20

var velocity = Vector2(0, 0)
var player_oxygen = BASE_OXYGEN
var has_item = false
var burst_cooldown = 5
var oxygen_tanks = 0
var engine_sound = -30
var engine_sound_target = 0
var was_above_water = false

func max_oxygen():
	return BASE_OXYGEN + oxygen_tanks * OXYGEN_TANK_SIZE

func set_canister_count(new_count):
	self.oxygen_tanks = new_count
	print(new_count)
	if new_count >= 1:
		$Canister1.visible = true

	if new_count >= 2:
		$Canister2.visible = true

func can_use_burst():
	return self.max_oxygen() > BURST_OXYGEN_USAGE + 10

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
		if player_oxygen > BURST_OXYGEN_USAGE + 10 and burst_cooldown < 1:
			player_oxygen -= 25
			burst_cooldown = 5
			$Explosion.frame = 0
			velocity += velocity.normalized() * BURST_ACCELERATION

	burst_cooldown -= 1 * delta

	var in_current = false
	var above_water = false
	for current in $DetectionArea.get_overlapping_areas():
		if (current as Area2D).get_collision_layer_bit(2):
			above_water = true
			player_oxygen = clamp(player_oxygen + 1, 0, max_oxygen())
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
		elif current.is_in_group("Canister"):
			self.set_canister_count(oxygen_tanks + 1)
			current.queue_free()
		elif current.is_in_group("Item"):
			if not has_item:
				current.queue_free()
				has_item = true
		elif current.is_in_group("PathEntry"):
			print("HYERE")
			var path = current.get_parent() as Path2D
			var follower = path.get_node("PathFollow2D") as PathFollow2D
			var animation = path.get_node("AnimationPlayer") as AnimationPlayer
			self.get_parent().remove_child(self)
			follower.add_child(self)
			self.position = Vector2(0, 0)
			self.rotation = 0
			animation.play("Follow")

	var max_speed
	if in_current:
		max_speed = MAX_CURRENT_SPEED
	elif burst_cooldown > 3:
		max_speed = MAX_BURST_SPEED
	elif above_water:
		max_speed = MAX_CURRENT_SPEED
	else:
		max_speed = MAX_MOVEMENT_SPEED

	if velocity.length() > max_speed:
		velocity *= 0.85

	if above_water:
		velocity += Vector2.DOWN * ACCELERATION * 2

	if above_water and not was_above_water:
		$SurfacingSound.play_once(1)
		was_above_water = true

	if not above_water and was_above_water:
		$SurfacingSound.play_once(1)
		was_above_water = false

	print(velocity.length())
	print(MAX_MOVEMENT_SPEED)
	if velocity.length() > MAX_MOVEMENT_SPEED:
		self.set_collision_mask_bit(5, false)
	else:
		self.set_collision_mask_bit(5, true)

	self.move_and_slide(velocity)

	for index in range(0, self.get_slide_count()):
		var collision = self.get_slide_collision(index)

		if velocity.length() > 3:
			velocity = -velocity * 0.95

		if velocity.length() > 10:
			$CollisionSound.play_once(collision.remainder.length())

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


























