extends Area2D

# Déclarer classe du joueur
class_name Joueur

# signal lorsque notre joueur est détruit
signal player_destroyed

# declarer variable pour la vitesse du joueur ici nous donnons la valeur de 250
@export var speed = 250 

# declarer variable pour la direction, on utilise Vector2 car nous nous déplacons seulement à droite et à gauche
# valeur a 0 car de base le joueur ne se déplace pas
var direction = Vector2.ZERO

# appel des objets collision et animation du joueur
@onready var collision_rect: CollisionShape2D = $CollisionShape2D
@onready var animation_player = $AnimationPlayer


# déclarer variables pour la collision avec les bordures du jeu et le joueur
var bounding_size_x
var start_bound
var end_bound 


# fonction qui permet les collisions avec les bordures
func _ready():
	# calcul de la taille de la zone de collision par rapport a sa forme
	bounding_size_x = collision_rect.shape.get_rect().size.x
	# taille visible de la fenêtre de jeu
	var rect = get_viewport().get_visible_rect()
	# camera 2D
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position
	#calcul des bordures droites et gauche du jeu par rapport a la fenetre
	start_bound = (camera_position.x - rect.size.x) / 2
	end_bound = (camera_position.x + rect.size.x) / 2
	
	
#methode appelé a chaqueframe pour mettre à jour le joueur
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
	
#méthode DESTRUCTION MAX DU JOEUR
func on_player_destroyed():
	speed = 0
	animation_player.play("destroy")


# LA c'est quand l'animation elle est fini pis voila
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
