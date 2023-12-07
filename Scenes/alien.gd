extends Area2D

class_name Alien
# singal alien detruit avec les points en param
signal alien_destroyed(points : int)
 
# objets Sprite et Animation dans alien
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

var config: Resource


# méthode quand instance alien prete
func _ready():
	sprite_2d.texture = config.sprite
	animation_player.play(config.animation_name)


# collision entre tir et alien
func _on_area_entered(area):
	if area is TirJoueur: 
		animation_player.play("destroy")
		area.queue_free()
		

# si animation destroy est active alors ANNIHILATION TOTAL du sprite de l'ennemi
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
		alien_destroyed.emit(config.points)
