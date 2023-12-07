extends Timer

class_name SpawnTimer


# valeur d'appartion du boss min et max
@export var min_timer = 7
@export var max_timer = 15



func _ready():
	setup_timer()


#spawn random entre la valeur min et max
func setup_timer():
	var random_time = randi_range(min_timer, max_timer)
	self.wait_time = random_time
	self.stop()
	self.start()
