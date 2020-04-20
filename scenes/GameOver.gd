extends Control


func _on_Label_all_text_visible():
	$GameOverSounds.get_random_sound().play()
