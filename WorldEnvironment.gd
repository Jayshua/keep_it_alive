extends WorldEnvironment

onready var player = $"../Player"

func _process(_delta):
	var depth = player.position.y
	self.environment.glow_intensity = lerp(0.5, 2, clamp(depth / 500, 0, 1))
	self.environment.glow_bloom = lerp(0.5, 2, clamp(depth / 500, 0, 1))
	self.environment.adjustment_brightness = lerp(1, 0.5, clamp(depth / 800, 0, 1))
	self.environment.adjustment_contrast = lerp(1, 3, clamp(depth / 1000, 0, 1))
