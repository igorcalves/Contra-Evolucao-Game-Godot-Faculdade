extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("Animated")

const scene: PackedScene = preload("res://ContraEvolucao/Sprites/Tanktaruga/bullet.tscn")

func _physics_process(delta):
	pass
	
func animated()->void:
	animation.play("bullet")




func _on_area_2d_body_entered(body):
	var cena = scene.instantiate()
	add_child(cena)


func _on_area_2d_body_exited(body):
	animation.play("RESET")
