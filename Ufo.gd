extends Area2D

class_name Ufo

@export var speed = 200
@onready var sprite_2d = $Sprite2D

@onready var depart_tir = $DepartTir
var explosion_texture = preload("res://Assets/Ufo/Ufo-explosion.png")

func _process(delta):
	position.x += delta * speed 


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is TirJoueur:
		depart_tir.queue_free()
		speed = 0
		sprite_2d.texture = explosion_texture
		await get_tree().create_timer(1.5).timeout
		queue_free()
