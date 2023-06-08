extends Node

const life: PackedScene = preload("res://Inimigos/dropLife/hearth.tscn")
const coin: PackedScene = preload("res://assets/Coin/coin.tscn")

var rng = RandomNumberGenerator.new()

var coins = 0
var kills = 0
var health = 100
var move_speed = 256
var damage = 10
var add_speed = 0
var add_healh = 0
var add_damage = 0
var scene_can_add = true
var NOT_can_move = false
var select_npc: int = 0
var final_boss

func _ready():
	pass
func pay_coins():
	coins -=10

func increase_speed(npc_speed: int) ->void:
	move_speed += npc_speed
	add_speed += npc_speed
	
func increase_health(npc_health: int) ->void:
	health += npc_health
	add_healh += npc_health
	
func increase_damage(npc_damage: int) -> void:
	damage += npc_damage
	add_damage += npc_damage
	
func drops(position:Vector2i) -> void:
	drop_life(position)
	drop_coin(position)	

func drop_life(position:Vector2i) -> void:
	var positions:Vector2i = Vector2i(position.x+13,position.y+10)
	var ran = rng.randi_range(1,2)
	ran =1
	if ran == 1:
		var drop_lifes = life.instantiate()
		drop_lifes.position = positions
		add_child(drop_lifes)
		return
	else:
		return
		

func drop_coin(position:Vector2i) ->void:
	var i = rng.randi_range(1,4)
	for j in i +1:
		match j:
			1:
				spawn_coins(position,-56)
			2:
				spawn_coins(position,0,56)
			3:
				spawn_coins(position,56,0)
			4:
				spawn_coins(position,0,-56)
		
func spawn_coins(positions:Vector2i,posx:int = 0,posy:int = 0) -> void:
	var position: Vector2i = Vector2i(positions.x + posx, positions.y + posy)
	var create_coin = coin.instantiate()
	create_coin.position = Vector2i(position.x,position.y)
	add_child(create_coin)
	
func check_is_NPC(body: CharacterBody2D) -> bool:
	if body.has_method("NPC") or body.has_method("NPC_2") or body.has_method("NPC_3"):
		if body.has_method("NPC"):
			select_npc = 1
		if body.has_method("NPC_2"):
			select_npc = 2
		if body.has_method("NPC_3"):
			select_npc = 3
		return true
	return false
