extends Control


const scene: PackedScene = preload("res://ContraEvolucao/controlGuide/control.tscn")

func _ready():
	
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))


func on_button_pressed(button_name:String) -> void:
	match button_name:
		"Voltar ao Jogo":
			queue_free()
			Global.NOT_can_move = false
			Global.scene_can_add = true
		"Recomecar":
			transitionScreen.scene_path = "res://ContraEvolucao/management/level.tscn"
			transitionScreen.fade_in()
			Global.NOT_can_move = false
			Global.scene_can_add = true
			Global.reset_status()
		"ir ao menu":
			transitionScreen.scene_path = "res://ContraEvolucao/management/menu.tscn"
			transitionScreen.fade_in()
			Global.NOT_can_move = false
			Global.scene_can_add = true
			
		"Sair do jogo":
			transitionScreen.can_quit = true
			Global.NOT_can_move = false
			transitionScreen.fade_in()
			Global.scene_can_add = true
