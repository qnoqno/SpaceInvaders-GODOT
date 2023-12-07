extends Area2D

#declare class tir du joeuur
class_name TirJoueur

#speed du tir joueur
@export var speed = 500 

#deplacement du tir vers le bas
func _process(delta):
	position.y -= delta * speed
