extends Node2D


@export var tirJoueur_scene: PackedScene

# variable si le joueur peut tirer
var can_player_shoot = true

# action avec le tir
func _input(event):
	if Input.is_action_just_pressed("Tir") && can_player_shoot:
		can_player_shoot = false
		var TirJoueur = tirJoueur_scene.instantiate() as TirJoueur
		TirJoueur.global_position = get_parent().global_position - Vector2(0, 20)
		get_tree().root.get_node("Game").add_child(TirJoueur)
		TirJoueur.tree_exited.connect(on_TirJoueur_destroyed)


# quand le tir du joueur est detruit il peut retirer
func on_TirJoueur_destroyed():
	can_player_shoot = true
