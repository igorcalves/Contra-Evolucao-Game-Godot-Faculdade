extends Control


func _on_button_pressed():
	queue_free()
	Global.scene_can_add = true
	Global.NOT_can_move = false
