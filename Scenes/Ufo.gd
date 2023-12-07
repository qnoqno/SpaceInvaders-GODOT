extends Area2D

class_name Ufo

#vitesse du boss
@export var speed = 300
@onready var sprite_2d = $Sprite2D


#texture boss
var explosion_texture = preload("res://Assets/Ufo/Ufo-explosion.png")

#deplacement du boss
func _process(delta):
	position.x += delta * speed 

# suppression du boss dans les parm
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#destruction du boss si touché par tir du joeuru + ptite animation sympa
func _on_area_entered(area):
	if area is TirJoueur:
		speed = 0
		sprite_2d.texture = explosion_texture
		await get_tree().create_timer(1.5).timeout
		queue_free()

