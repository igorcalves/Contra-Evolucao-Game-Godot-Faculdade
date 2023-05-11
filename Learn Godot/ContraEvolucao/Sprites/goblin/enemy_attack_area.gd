extends Area2D

@export var damage: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_body_entered(body):
	body.update_health(damage)


func on_lifetime_timeout() -> void:
	queue_free()
