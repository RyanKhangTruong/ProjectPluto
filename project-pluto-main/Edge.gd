extends Area2D

func _on_Edge_area_entered(area):
	if area.has_method("turn_around"):
		area.turn_around()
