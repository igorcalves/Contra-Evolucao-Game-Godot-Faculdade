extends Control


const scene: PackedScene = preload("res://ContraEvolucao/controlGuide/control.tscn")

func _ready():
	
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))


func on_button_pressed(button_name:String) -> void:
	match button_name:
		"NewGame":
			transitionScreen.scene_path = "res://ContraEvolucao/management/level.tscn"
			transitionScreen.fade_in()
			
		"Quit":
			transitionScreen.can_quit = true
			transitionScreen.fade_in()
			
		"Controls":
			var cena = scene.instantiate()
			add_child(cena)
