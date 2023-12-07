extends CanvasLayer


# texture pr les 3 vies
var vie_texture = preload("res://Assets/Player/Player.png")

# variables des interfrces
@onready var vies_interface = $MarginContainer/HBoxContainer
@onready var pointspoints = $Pointspoints
@onready var points_compteur = $"../CompteurPoints" as CompteurPoints
@onready var vie = $"../Vie" as Vie
@onready var spawn_alien = $"../SpawnAlien" as SpawnAlien
@onready var partie_perdu = $MarginContainer/partie_perdu
@onready var partie_gagne = $MarginContainer/partie_gagne
@onready var winwin = %winwin



func _ready(): 
	# evolution des points
	pointspoints.text = "%d" % 0
	points_compteur.on_points_increased.connect(points_increased)
	# connexion avec spawnalien si la partie est gaagné ou perdu
	spawn_alien.partie_perdu.connect(on_partie_perdu)
	spawn_alien.partie_gagné.connect(on_partie_gagné)
	# connexion avec les vies 
	vie.vie_perdu.connect(on_vie_perdu)
	
	# ajout textures des vies à l'interface
	for i in range(vie.vies):
		var vie_texture_rect =  TextureRect.new()
		vie_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		vie_texture_rect.custom_minimum_size = Vector2(40, 25)
		vie_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		vie_texture_rect.texture = vie_texture
		vies_interface.add_child(vie_texture_rect)

# augmentation des points vers le label pointspoints
func points_increased(points : int):
	pointspoints.text = "%d" % points

# afficher gameover si la partie est perdu
func on_partie_perdu():
	partie_perdu.visible = true

# afficher win si la partie est gagné
func on_partie_gagné():
	partie_gagne.visible = true
	
# fonction pour restart le jeu si on veut recommencer une partie
func _process(delta):
	if Input.is_action_pressed("Restart"):
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

# si une vie est perdu on l'enleve si y'en a plus la partie est perdu
func on_vie_perdu(vies_restantes : int):
	if vies_restantes != 0:
		var vie_texture_rect = vies_interface.get_child(vies_restantes)
		vie_texture_rect.queue_free()
	else:
		on_partie_perdu()
