extends Node

class_name Vie

signal vie_perdu(vies_restantes : int)
 


@export var vies = 3
@onready var joueur: Joueur = $"../Joueur"
var joueur_scn = preload("res://Scenes/joueur.tscn")

func _ready():
	(joueur as Joueur).player_destroyed.connect(on_player_destroyed)

func on_player_destroyed():
	vies -= 1
	vie_perdu.emit(vies)
	if vies != 0 :
		joueur = joueur_scn.instantiate() as Joueur
		joueur.global_position = Vector2(0, 302)
		joueur.player_destroyed.connect(on_player_destroyed)
		get_tree().root.get_node("Game").add_child(joueur)
	


