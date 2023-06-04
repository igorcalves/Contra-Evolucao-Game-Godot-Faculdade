extends Node

const life: PackedScene = preload("res://Inimigos/dropLife/hearth.tscn")
const coin: PackedScene = preload("res://assets/Coin/coin.tscn")

var rng = RandomNumberGenerator.new()

var coins = 0
var kills = 0
var health = 10
var move_speed = 800
var damage = 5
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

func drop_life(position:Vector2i) -> void:
	var ran = rng.randi_range(1,2)
	if ran == 1:
		var drop_lifes = life.instantiate()
		drop_lifes.position = position
		add_child(drop_lifes)
		return
	else:
		return
		

func drop_coin(position:Vector2i) ->void:
	var i = rng.randi_range(1,3)
	i = 5
	for j in i:
		match j:
			1:
				spawn_coins(position)
			2:
				spawn_coins(position,56,-35)
			3:
				spawn_coins(position,112,-35)
			4:
				spawn_coins(position,56,-90)
		
func spawn_coins(positions:Vector2i,posx:int = 0,posy:int = -35) -> void:
	var position: Vector2i = Vector2i(positions.x + posx, positions.y + posy)
	var create_coin = coin.instantiate()
	create_coin.position = Vector2i(position.x,position.y)
	add_child(create_coin)
