extends CanvasLayer


# l'affichage du menu est composé de Label et de Texture


# Lancement du jeu quand la touche ENTREE est appuyée
func _process(delta):
	if Input.is_action_pressed("Start"):
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
