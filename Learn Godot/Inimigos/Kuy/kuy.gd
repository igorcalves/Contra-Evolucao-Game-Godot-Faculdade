extends CharacterBody2D

const ATTACK_AREA: PackedScene = preload("res://ContraEvolucao/Sprites/goblin/enemy_attack_area.tscn")
const OFFSET: Vector2 = Vector2(0,31)

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var aux_animation_player: AnimationPlayer = get_node("AuxAnimationPlayer")
@onready var texture: Sprite2D = get_node("Texture")
@onready var collision: CollisionShape2D = get_node("Collision")


var player_ref: CharacterBody2D = null
var can_die: bool = false
var kills = 1
var alter_attack = true


@export var health = 10
@export var move_speed: float = 192.0
@export var distance_threshold: float = 60.0


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
		if alter_attack:
			animation.play("attack1")
			return
		if alter_attack == false:
			animation.play("attack2")
			return

	
	velocity = direction * move_speed
	move_and_slide()
	animate()
	
func spawn_attack_area() -> void:
	var attack_area = ATTACK_AREA.instantiate()
	attack_area.position = OFFSET
	add_child(attack_area)
	
func animate() ->void:
	if velocity.x > 0:
		texture.flip_h = true
		collision.position = Vector2i(-11,14)

	if velocity.x < 0:
		texture.flip_h = false
		collision.position = Vector2i(20,14)
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
	if body.has_method("NPC"):
		return
	player_ref = body
	
func on_detection_area_body_exited(_body):
	player_ref = null

func on_animation_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
		Global.drops(global_position)
	if anim_name == "attack1":
		alter_attack = false
	if anim_name == "attack2":
		alter_attack = true
