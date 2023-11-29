extends Node2D


class_name SpawnAlien
const rangés = 5
const colonnes = 11
const horizontal_spacing = 40
const vertical_spacing =  12
const alien_height = 32
const start_y_position = 10
const alien_position_x_increment = 10
const alien_position_y_increment = 20

var movement_direction = 1


var alien_scn = preload("res://Scenes/alien.tscn")

#NODE REFERENCE
@onready var mouvement_timer = $MouvementTimer



func _ready():
	#SETUP TIMER 
	mouvement_timer.timeout.connect(move_aliens)
	
	
	var alien1_res = preload("res://Resources/alien1.tres")
	var alien2_res = preload("res://Resources/alien2.tres")
	var alien3_res = preload("res://Resources/alien3.tres")
	
	
	var config_alien
	
	for rangé in rangés:
		if rangé == 0:
			config_alien = alien1_res
		elif rangé == 1 || rangé == 2:
			config_alien = alien2_res
		elif rangé == 3 || rangé == 4:
			config_alien = alien3_res
		
		var rangé_width = (colonnes * config_alien.width * 3) + ((colonnes - 1) * horizontal_spacing)
		var start_x = (position.x - rangé_width) / 2
		
		for colonne in colonnes:
			var x = start_x + (colonne * config_alien.width * 3) + (colonne * horizontal_spacing)
			var y = start_y_position + (rangé * alien_height) + (rangé * vertical_spacing)
			var spawn_position = Vector2(x,y)
			
			spawn_alien(config_alien, spawn_position)
			
			
func spawn_alien(config_alien, spawn_postition : Vector2):
	var alien = alien_scn.instantiate() as Alien
	alien.config = config_alien
	alien.global_position =  spawn_postition
	add_child(alien)

func move_aliens():
	position.x += alien_position_x_increment * movement_direction

func _on_mur_droite_area_entered(area):
	if (movement_direction == 1):
		position.y += alien_position_y_increment
		movement_direction *= -1
		


func _on_mur_gauche_area_entered(area):
	if (movement_direction == -1):
		position.y += alien_position_y_increment
		movement_direction *= -1


func _on_mur_bas_area_entered(area):
	pass # Replace with function body.
