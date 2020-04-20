extends AnimatedSprite

onready var scream = $Scream
var target = null
var speed = 0.75;
var audio_target = -80


func _process(delta):
	if scream.volume_db < audio_target:
		scream.volume_db += 5
	elif scream.volume_db > audio_target:
		scream.volume_db -= 0.5

	if audio_target == -80 and scream.volume_db == audio_target and scream.playing:
		scream.stop()
	if audio_target == -5 and not scream.playing:
		scream.play()

	
func _physics_process(delta):
	if target:
		set_position(lerp(get_position(), target.position, speed * delta))
		self.look_at(target.position)

	if target and not scream.playing:
		audio_target = -5
	elif not target and scream.playing:
		audio_target = -80


func _on_Aggro_body_entered(body):
	if body.name == "Player":
		target = body


func _on_Aggro_body_exited(body):
	if body.name == "Player":
		target = null
