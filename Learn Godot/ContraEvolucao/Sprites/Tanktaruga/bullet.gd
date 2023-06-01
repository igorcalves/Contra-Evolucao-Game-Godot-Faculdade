extends Node2D

@onready var animation_play: AnimationPlayer = get_node("AnimationPlayer")
var damage = 1.5


func _process(delta):
	animation_play.play("bullet_run")

func _on_area_2d_body_entered(body):
	if body.has_method("NPC"):
		return
	body.update_health(damage)
	if body.has_method("PLAYER"):
		queue_free()
		


func _on_animation_player_animation_finished(anim_name):
	queue_free()
