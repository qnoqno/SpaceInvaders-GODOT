extends Area2D


@export var speed = 250
var direction = Vector2.ZERO

@onready var collision_rect: CollisionShape2D = $CollisionShape2D

func _ready():
	pass
	
func _process(delta):
	var input = Input.get_axis("gauche", "droite")
	
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO

	var movement = speed * delta * direction.x
	position.x += movement
