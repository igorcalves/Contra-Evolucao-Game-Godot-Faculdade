extends Node2D



func _on_area_2d_body_entered(body):
	Global.health += 5
	queue_free()
