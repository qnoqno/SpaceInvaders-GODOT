extends Node2D


class_name SpawnAlien

#signal emis aux autres noeuds
signal alien_destroyed(points: int)
signal partie_gagné
signal partie_perdu

# toutes les variables pour les aliens
const rangés = 5
const colonnes = 11
const horizontal_spacing = 40
const vertical_spacing =  12
const alien_height = 32
const start_y_position = 10
var alien_position_x_increment = 13
const alien_position_y_increment = 24

var movement_direction = 1

# chargement des scenes
var alien_scn = preload("res://Scenes/alien.tscn")
var tir_alien_scn = preload("res://Scenes/tir_alien.tscn")

# compteurs pour les aliens détruits
var alien_destroyed_count = 0
var alien_total_count = rangés * colonnes


@onready var mouvement_timer = $MouvementTimer
@onready var tir_timer = $TirTimer

# apparition des aliens
func _ready():
	
	mouvement_timer.timeout.connect(move_aliens)
	tir_timer.timeout.connect(on_alien_tir)
	
	# on recupere les sprites qu'on a personnalisé
	var alien1_res = preload("res://Resources/alien1.tres")
	var alien2_res = preload("res://Resources/alien2.tres")
	var alien3_res = preload("res://Resources/alien3.tres")
	
	
	var config_alien
	
	# on fait apparaitre les ennemis dans l'ordre que l'on souhaite
	for rangé in rangés:
		if rangé == 0:
			config_alien = alien1_res
		elif rangé == 1 || rangé == 2:
			config_alien = alien2_res
		elif rangé == 3 || rangé == 4:
			config_alien = alien3_res
		
		# calcul position pour chaque alien
		var rangé_width = (colonnes * config_alien.width * 3) + ((colonnes - 1) * horizontal_spacing)
		var start_x = (position.x - rangé_width) / 2
		
		for colonne in colonnes:
			var x = start_x + (colonne * config_alien.width * 3) + (colonne * horizontal_spacing)
			var y = start_y_position + (rangé * alien_height) + (rangé * vertical_spacing)
			var spawn_position = Vector2(x,y)
			
			spawn_alien(config_alien, spawn_position)

# génerer alien
func spawn_alien(config_alien, spawn_position : Vector2):
	var alien = alien_scn.instantiate() as Alien
	alien.config = config_alien
	alien.global_position =  spawn_position
	alien.alien_destroyed.connect(on_alien_destroyed)
	add_child(alien)

# faire bouger alien plus vite moins yen a 
func move_aliens():
	if (alien_destroyed_count >= 0 and alien_destroyed_count < 10):
		position.x += alien_position_x_increment * movement_direction
	if (alien_destroyed_count >= 10 and alien_destroyed_count < 20):
		alien_position_x_increment += 0.1
		position.x += alien_position_x_increment * movement_direction
	if (alien_destroyed_count >= 20 and alien_destroyed_count < 30):
		alien_position_x_increment += 0.13
		position.x += alien_position_x_increment * movement_direction
	if (alien_destroyed_count >= 30 and alien_destroyed_count < 40):
		alien_position_x_increment += 0.16
		position.x += alien_position_x_increment * movement_direction
	if (alien_destroyed_count >= 40 and alien_destroyed_count < 55):
		alien_position_x_increment += 0.2
		position.x += alien_position_x_increment * movement_direction

# faire descendre alien quand il tape le mur de droite
func _on_mur_droite_area_entered(area):
	if (movement_direction == 1):
		position.y += alien_position_y_increment
		movement_direction *= -1
		

# faire descendre alien quand il tape le mur de gauche
func _on_mur_gauche_area_entered(area):
	if (movement_direction == -1):
		position.y += alien_position_y_increment
		movement_direction *= -1

# partie perdu quand alien atteint limite en bas du jeu
func _on_mur_bas_area_entered(area):
	partie_perdu.emit()
	mouvement_timer.stop()
	movement_direction = 0

# random tir pour les aliens
func on_alien_tir():
	var random_child_position = get_children().filter(func (child):return child is Alien).map(func (alien):return alien.global_position).pick_random()
	var tir_alien = tir_alien_scn.instantiate() as Tir_Alien
	
	tir_alien.global_position = random_child_position
	get_tree().root.add_child(tir_alien)

# donner des points quand alien detruit
func on_alien_destroyed(points : int):
	alien_destroyed.emit(points)
	alien_destroyed_count += 1
	
	# si tout alien detruit partie gagné
	if alien_destroyed_count == alien_total_count:
		partie_gagné.emit()
		tir_timer.stop()
		mouvement_timer.stop()
		movement_direction = 0

