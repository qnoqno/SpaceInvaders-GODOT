extends Node2D

@onready var spawn_timer: SpawnTimer = $SpawnTimer
var projectile_scn = preload("res://Scenes/tir_alien.tscn")



func _ready():
	(spawn_timer as SpawnTimer).setup_timer()
	spawn_timer.timeout.connect(on_spawn_timer_timeout) 

func on_spawn_timer_timeout():
	var projectile = projectile_scn.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D") as Sprite2D
	projectile_sprite.modulate = Color(0.6, 0, 0)
	projectile.global_position = global_position
	get_tree().root.add_child(projectile)
	spawn_timer.setup_timer()
