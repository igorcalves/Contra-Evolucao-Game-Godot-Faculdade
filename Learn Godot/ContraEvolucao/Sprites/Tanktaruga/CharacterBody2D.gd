extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("Animated")


func _physics_process(delta):
	pass
	
func animated()->void:
	animation.play("bullet")




func _on_area_2d_body_entered(body):
	animated()


func _on_area_2d_body_exited(body):
	animation.play("RESET")
