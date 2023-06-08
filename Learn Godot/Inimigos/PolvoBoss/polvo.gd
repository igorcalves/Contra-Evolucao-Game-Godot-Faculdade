extends CharacterBody2D

const ATTACK_AREA: PackedScene = preload("res://Inimigos/PolvoBoss/enemy_attack_area_polvo.tscn")
const attack_weaves: PackedScene = preload("res://Inimigos/PolvoBoss/attack.tscn")
const attack_weaves_left: PackedScene = preload("res://Inimigos/PolvoBoss/attack(left).tscn")
const final_dialogue: PackedScene = preload("res://ContraEvolucao/dialog/final_dialog.tscn")
const NPC: PackedScene = preload("res://ContraEvolucao/Sprites/npc/npc_3.tscn")
const OFFSET: Vector2 = Vector2(0,31)

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var aux_animation_player: AnimationPlayer = get_node("AuxAnimationPlayer")
@onready var texture: Sprite2D = get_node("Texture")
@onready var collision: CollisionShape2D = get_node("Collision")

var player_ref: CharacterBody2D = null
var can_die: bool = false
var kills = 1
var special_attack: bool = false
var change_side = false


@export var health = 45
@export var move_speed: float = 180.0
@export var distance_threshold: float = 1800





func _physics_process(_delta: float) -> void:
	if can_die:
		return
	if player_ref == null or player_ref.can_die:
		velocity = Vector2.ZERO
		animate()
		return
		
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance: float = global_position.distance_to(player_ref.global_position)
	
	if distance < 160:
		animation.play("attack")
		return
	if special_attack:
		spawn_attack_weave()
	velocity = direction * move_speed
	move_and_slide()
	animate()
	

func spawn_attack_weave():
	if change_side:
		var scene_attack = attack_weaves.instantiate()
		scene_attack.position = Vector2(0,0)
		add_child(scene_attack)
		special_attack = false
		return
		
	if change_side == false:
		var scene_attack = attack_weaves_left.instantiate()
		scene_attack.position = Vector2(0,0)
		add_child(scene_attack)
		special_attack = false
		return
	
	
func spawn_attack_area() -> void:
	var attack_area = ATTACK_AREA.instantiate()
	attack_area.position = OFFSET
	add_child(attack_area)
	
func animate() ->void:
	if velocity.x > 0:
		texture.flip_h = false
		collision.position = Vector2i(-20,14)
		change_side = false
		
	if velocity.x < 0:
		texture.flip_h = true
		collision.position = Vector2i(33,14)
		change_side = true
		
	if velocity != Vector2.ZERO:
		animation.play("walk")
		return
	
	animation.play("idle")	
	
func update_health(value: int) -> void:
	health -= value
	if health<= 0:
		can_die = true
		animation.play("death")
		Global.kills += kills
		
		return		
	aux_animation_player.play("hit")
func on_detection_area_body_entered(body):
	if Global.check_is_NPC(body):
		return
	player_ref = body
	
func on_detection_area_body_exited(_body):
	player_ref = null

func on_animation_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
	Global.final_boss = true


func _on_timer_timeout():
	special_attack = true
