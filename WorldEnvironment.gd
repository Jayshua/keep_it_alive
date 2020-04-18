extends WorldEnvironment

onready var player = $"../Player"

func _process(delta):
	var depth = player.position.y
	self.environment.glow_intensity = lerp(0, 1.2, clamp(depth / 500, 0, 1))
	self.environment.glow_bloom = lerp(0, 1.2, clamp(depth / 500, 0, 1))
	self.environment.adjustment_brightness = lerp(1, 0.6, clamp(depth / 500, 0, 1))
	self.environment.adjustment_contrast = lerp(1, 1.5, clamp(depth / 500, 0, 1))
