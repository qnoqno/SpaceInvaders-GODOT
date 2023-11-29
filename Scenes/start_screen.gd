extends CanvasLayer

func _process(delta):
	if Input.is_action_pressed("Start"):
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
