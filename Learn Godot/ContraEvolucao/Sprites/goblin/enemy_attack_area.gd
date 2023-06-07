extends Area2D


var damage = 0.5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_body_entered(body):
	if Global.check_is_NPC(body):
		return
	body.update_health(damage)


func on_lifetime_timeout() -> void:
	queue_free()
