extends AudioStreamPlayer

export(NodePath) var player_path

onready var player = get_node(player_path) as KinematicBody2D

const OFF_VOLUME = -50
const ON_VOLUME = -9

var target_volume = -50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y > 300:
		target_volume = ON_VOLUME
	elif player.position.y < 300:
		target_volume = OFF_VOLUME

	if self.volume_db < target_volume:
		self.volume_db += 0.1
	elif self.volume_db > target_volume:
		self.volume_db -= 0.1
	
	if self.volume_db == target_volume and target_volume == OFF_VOLUME and self.playing:
		self.stop()
	elif not self.playing and target_volume == ON_VOLUME:
		self.play(0)

	
