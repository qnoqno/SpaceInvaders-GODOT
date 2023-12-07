extends Area2D



# quand le tir atteint la limite au top ( comme dorian) il est supprimé ( pas comme dorian)
func _on_area_entered(area):
	area.queue_free()
