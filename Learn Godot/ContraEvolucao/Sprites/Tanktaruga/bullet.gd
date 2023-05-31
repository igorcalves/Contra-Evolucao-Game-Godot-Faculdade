extends Node2D

var damage = 1.5


func _on_area_2d_body_entered(body):
	if body.has_method("NPC"):
		return
	body.update_health(damage)
	if body.has_method("PLAYER"):
		queue_free()
		
