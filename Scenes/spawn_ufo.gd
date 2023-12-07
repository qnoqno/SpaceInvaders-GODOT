extends Node2D

# on fait venir la variable timer pr lapparition du boss
@onready var spawn_timer = $SpawnTimer

# chargement de la scene du boss
var ufo_scn: PackedScene = preload("res://Scenes/ufo.tscn")

# config du timer 
func _ready():
	(spawn_timer as SpawnTimer).setup_timer()


func _on_spawn_timer_timeout():
	var ufo  = ufo_scn.instantiate()
	ufo.global_position = position
	get_tree().root.add_child(ufo)
