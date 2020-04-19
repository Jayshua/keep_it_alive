extends TextureProgress

func _on_Player_oxygen_change(oxygen):
	self.value = oxygen
