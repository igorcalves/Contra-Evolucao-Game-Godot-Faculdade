extends CharacterBody2D

@onready var attack_area_collision_turned: CollisionShape2D = get_node("AttackTurnedArea/ColissitonAreaAttackTurned")
@onready var attack_area_collision_Down: CollisionShape2D = get_node("AttackDownArea/ColissitonAreaAttackDown")
@onready var attack_area_collision_Up: CollisionShape2D = get_node("AttackUpArea/ColissitonAreaAttackUp")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var texture: Sprite2D = get_node("Texture")
@onready var aux_animation_play: AnimationPlayer = get_node("AuxAnimationPlayer")

var can_attack: bool = true
var can_die: bool = false
var sides : String = ""
var npc_in_range = false


@export var health: int = 10
@export var move_speed: float = 256
@export var damage: int = 1


func _physics_process(_delta: float) -> void:
	if can_attack == false or can_die:
		return
	match_slide()	
	move()
	animate()
	attack_handler()

	
	
func move() -> void:
	var direction: Vector2 = get_direction()
	velocity = direction * move_speed
	move_and_slide()
	
func match_slide() -> void:
	if Input.is_action_just_pressed("move_up"):
		sides = "Up"
	elif Input.is_action_just_pressed("move_down"):
		sides = "Down"
	elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		sides = "Turned"
		
func get_direction()-> Vector2:
	return Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()
	
func animate() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_collision_turned.position.x = 12.094
		
		
	if velocity.x <0:
		attack_area_collision_turned.position.x = -12.094
		texture.flip_h = true
	
	if velocity != Vector2.ZERO:
		animation.play(get_animation_direction(velocity))
		return
	match sides:
		"Up":
			animation.play("idleuP")
		"Down":
			animation.play("idle")
		"Turned":
			animation.play("idleTurned")
		_:
			animation.play("idle")
	
func attack_handler() -> void:
	if Input.is_action_just_pressed("attack") and can_attack:
		can_attack = false

		if sides == "Up":
			animation.play("AttackUp")
		elif sides == "Down":
			animation.play("AttackDown")
		elif sides == "Turned":
			animation.play("AttackTurned")
		else:
			animation.play("AttackDown")  # animação padrão


		

func get_animation_direction(direction: Vector2) ->String:
	if direction.x < 0:
		return "RunTurned"
	elif direction.x > 0:
		return "RunTurned"
	elif direction.y < 0:
		return "runUp"
	elif direction.y > 0:
		return "RunDown"
	else:
		return ""
	



func on_animation_finished(anim_name:String):
	match anim_name:
		"AttackTurned":
			can_attack = true
		"AttackDown":
			can_attack = true
		"AttackUp":
			can_attack = true
		"Death":
			get_tree().reload_current_scene()


# ----------------------attack Functions--------------------------#
func on_attack_area_body_entered_Down(body):
	body.update_health(damage)

func on_attack_area_body_entered_Up(body):
	body.update_health(damage)


func on_attack_area_body_entered_Turned(body):
	body.update_health(damage)

func update_health(value: int) -> void:
	health -= value
	if health <= 0:
		can_die = true
		animation.play("Death")
		attack_area_collision_Down.set_deferred("disabled",true)
		attack_area_collision_turned.set_deferred("disabled",true)
		attack_area_collision_Up.set_deferred("disabled",true)
		Global.health = 0

		return
	
	aux_animation_play.play("hit")
	Global.health -= 1
	


func on_detection_area_body_entered(body):
	if body.has_method("NPC"):
		npc_in_range = true


func on_detection_area_body_exited(body):
	if body.has_method("NPC"):
		npc_in_range = false
