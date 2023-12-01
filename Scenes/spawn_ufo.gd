extends Node2D

@onready var spawn_timer = $SpawnTimer
var ufo_scn: PackedScene = preload("res://Scenes/ufo.tscn")


func _ready():
	(spawn_timer as SpawnTimer).setup_timer()





func _on_spawn_timer_timeout():
	var ufo  = ufo_scn.instantiate()
	ufo.global_position = position
	get_tree().root.add_child(ufo)
