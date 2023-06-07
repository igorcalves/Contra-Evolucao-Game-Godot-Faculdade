extends Node2D

var damage = 5

func _on_animation_player_animation_finished(anim_name):
	if anim_name =="new":
		queue_free()


func on_body_entered(body):
	if Global.check_is_NPC(body):
		return
	body.update_health(damage)

