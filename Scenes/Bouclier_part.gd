extends Area2D

@export var sprite: Sprite2D
@export var texture_array: Array[Texture2D]

var damage = 0
const max_damage = 3

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is TirJoueur || area is Tir_Alien:
		area.queue_free()
		if damage < max_damage:
			damage += 1
			sprite.texture = texture_array[damage - 1]
		else:
			queue_free()
	if area is  Alien:
		queue_free()



