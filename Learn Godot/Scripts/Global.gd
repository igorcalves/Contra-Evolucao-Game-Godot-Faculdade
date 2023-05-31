extends Node

var coins = 0
var kills = 0
var health = 10
var move_speed = 256
var damage = 1
var add_speed = 0
var add_healh = 0
var add_damage = 0
var scene_can_add = true
var NOT_can_move = false



func _ready():
	pass

func increase_speed(npc_speed: int) ->void:
	move_speed += npc_speed
	add_speed += npc_speed
	
func increase_health(npc_health: int) ->void:
	health += npc_health
	add_healh += npc_health
	
func increase_damage(npc_damage: int) -> void:
	damage += npc_damage
	add_damage += npc_damage	

