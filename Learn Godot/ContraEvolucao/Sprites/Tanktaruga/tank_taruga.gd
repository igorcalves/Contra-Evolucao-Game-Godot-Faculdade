extends CharacterBody2D

const ATTACK_AREA: PackedScene = preload("res://ContraEvolucao/Sprites/goblin/enemy_attack_area.tscn")
const bullet_left_scene: PackedScene = preload("res://ContraEvolucao/Sprites/Tanktaruga/bullet(left).tscn")
const bullet_right_scene: PackedScene = preload("res://ContraEvolucao/Sprites/Tanktaruga/bullet(right).tscn")
const OFFSET: Vector2 = Vector2(0,7)

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var animation_hit: AnimationPlayer = get_node("AnimationHit")
@onready var texture: Sprite2D = get_node("Texture")
@onready var colission: CollisionShape2D = get_node("Collision")

var player_ref: CharacterBody2D = null
var can_die: bool = false
var kills = 1
var change_side = false

@export var health = 5
@export var move_speed: float = 192.0
@export var distance_threshold: float = 90


func _physics_process(_delta: float) -> void:
	if can_die:
		return
	if player_ref == null or player_ref.can_die:
		velocity = Vector2.ZERO
		animate()
		return
		
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance: float = global_position.distance_to(player_ref.global_position)
	
	if distance < distance_threshold:
		animation.play("Attack_2")
		return
	if distance < 150:
		check_flip_H()
		animation.play("Attack_4")
		return
	velocity = direction * move_speed
	move_and_slide()
	animate()

	
func animate() ->void:
	check_flip_H()
	if velocity != Vector2.ZERO:
		animation.play("Walk")
		return
	
	animation.play("idle")	

func check_flip_H():
	if velocity.x > 0:
		texture.flip_h = true
		change_side = true
		colission.position.x = -10

	if velocity.x < 0:
		texture.flip_h = false 
		change_side = false
		colission.position.x = 10
	
func update_health(value: int) -> void:
	health -= value
	if health<= 0:

		can_die = true
		animation.play("Death")
		Global.kills += kills
		
		return
		
	animation_hit.play("hit")
func spawn_attack_area() -> void:
	call_deferred("_add_attack_area_scene")

func spawn_bullet():
	if change_side:
		call_deferred("_add_right_bullet_scene")
	if change_side == false:
		call_deferred("_add_bullet_scene")
	


func _add_bullet_scene():
	var scene = bullet_left_scene.instantiate()
	scene.position = OFFSET
	add_child(scene)
	
func _add_right_bullet_scene():
	var scene = bullet_right_scene.instantiate()
	scene.position = OFFSET
	add_child(scene)


func _add_attack_area_scene():
	var attack_area = ATTACK_AREA.instantiate()
	attack_area.position = OFFSET
	add_child(attack_area)		


func stop_move():
	move_speed = 0


func _on_dection_area_for_shot_body_entered(body):
	check_flip_H()
	if Global.check_is_NPC(body):
		return
	player_ref = body


func _on_dection_area_for_shot_body_exited(body):
	player_ref = null
	move_speed = 192.0


func _on_animation_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
		Global.drops(global_position)
