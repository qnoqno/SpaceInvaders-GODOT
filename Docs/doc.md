# Doc Dev

  

## Technologies utilisées

  

- [Godot](https://godotengine.org/) est un moteur de jeu, nous l'utilisons car il est utilisable sur Web

- [Itch.io](https://itch.io/) est une site où l'on peut poster des jeux indépendants gratuitement

  

## Structure du projet

  

-  **Assets**  *Fichier pour les sprites et font*

-  **Addons**  *Fichier pour la base de donnée* (non terminé)

-  **Resources**  *Fichier comprenant les aliens et leurs caractéristiques*

-  **Scenes**  *Fichier comprenant toutes les scenes et le code du jeu*

  

## Structure du code

### Fonction général

**Déplacement du joueur**

```
func _process(delta):
	#récup des touches droites et gauches du clavier
	var input = Input.get_axis("Droite","Gauche")
	#dépalcemnet du joueur en fonction de sur quel touche il appuie
	if input > 0:
		direction = Vector2.LEFT
	elif input < 0:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
	
	#calcul du déplacement
	var delta_movement = speed * delta * direction.x
	if (position.x + delta_movement < start_bound + bounding_size_x * transform.get_scale().x ||
		position.x + delta_movement > end_bound - bounding_size_x * transform.get_scale().x):
		return
	
	#MaJ Position
	position.x += delta_movement 
```
**Tir du joueur**
```
 extends Area2D

#declare class tir du joeuur
class_name TirJoueur

#speed du tir joueur
@export var speed = 500 

#deplacement du tir vers le bas
func _process(delta):
	position.y -= delta * speed
```
**Spawn des aliens**
```
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
```
**Mouvement des aliens**
```
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
```
**Elimination des aliens**
```
func _on_area_entered(area):
	if area is TirJoueur: 
		animation_player.play("destroy")
		area.queue_free()
```

