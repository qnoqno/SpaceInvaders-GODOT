extends Area2D


class_name Tir_Alien

# vitesse du tir de l'alien
@export var speed = 400


# deplacement du tir vers le bas
func _process(delta):
	position.y += speed * delta 

# suppression du tir dans les param
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# destruction du joueur quand touché par tir 
func _on_area_entered(area):
	if area is Joueur:
		(area as Joueur).on_player_destroyed()
		queue_free()
