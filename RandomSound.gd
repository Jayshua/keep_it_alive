extends Node

var unused_sounds = []

func get_random_sound():
	if unused_sounds.size() == 0:
		unused_sounds = self.get_children()
		randomize()
		unused_sounds.shuffle()
		unused_sounds.shuffle()

	return unused_sounds.pop_back()
