extends AudioStreamPlayer

export(NodePath) var player_path
export(int) var off_volume
export(int) var on_volume
export(float) var begin_depth
export(float) var end_depth

onready var player = get_node(player_path) as KinematicBody2D

var target_volume = off_volume

func _ready():
	self.volume_db = target_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y > begin_depth and player.position.y < end_depth:
		target_volume = on_volume
	else:
		target_volume = off_volume

	if self.volume_db < target_volume:
		self.volume_db += 0.05
	elif self.volume_db > target_volume:
		self.volume_db -= 0.05
	
	if self.volume_db == target_volume and target_volume == off_volume and self.playing:
		self.stop()
	elif not self.playing and target_volume == on_volume:
		self.play(0)

	
