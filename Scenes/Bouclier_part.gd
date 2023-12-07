extends Area2D

# on fait venir les sprites et les textures
@export var sprite: Sprite2D
@export var texture_array: Array[Texture2D]

# on declare les dommages et le maximum de dommage que peut prendre le mur
var damage = 0
const max_damage = 3

# on appel la fonction lorsque ca rentre dans la zone de colli du mur
func _ready():
	self.area_entered.connect(_on_area_entered)

# peu importe le tir le mur prendra -1 PTS DE DEGATS et sera suppr apres 3
func _on_area_entered(area):
	if area is TirJoueur || area is Tir_Alien:
		area.queue_free()
		if damage < max_damage:
			damage += 1
			sprite.texture = texture_array[damage - 1] 
		else:	
			queue_free()
	# si c'est pas un tir mais un alien le mur se detruit completement
	if area is  Alien:
		queue_free()



