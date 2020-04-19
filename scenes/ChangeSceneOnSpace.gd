extends Control


export(Resource) var scene


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to(scene)
