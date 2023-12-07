extends Node

class_name  CompteurPoints

signal on_points_increased(points: int)
#points de base a 0
var points = 0 

@onready var spawn_alien = $"../SpawnAlien" as SpawnAlien

#augmentation des poitns qd alien dertruit
func _ready():
	spawn_alien.alien_destroyed.connect(augm_points)
	
# augmentation des poitns
func augm_points(points_ajouté: int):
	points += points_ajouté
	on_points_increased.emit(points)


