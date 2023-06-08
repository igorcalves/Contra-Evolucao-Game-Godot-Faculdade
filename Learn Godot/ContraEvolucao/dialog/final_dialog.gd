extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))


func on_button_pressed(button_name:String) -> void:
	match button_name:
		"Continuar":
			Global.NOT_can_move = false
			queue_free()
			
		"Voltar ao menu":
			transitionScreen.scene_path = "res://ContraEvolucao/management/menu.tscn"
			transitionScreen.fade_in()
			
