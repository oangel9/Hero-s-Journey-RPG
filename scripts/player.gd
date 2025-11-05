extends CharacterBody2D
class_name Player

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_colshape: CollisionShape2D = $SwordHitBox/CollisionShape2D
@onready var pistol_colshape: CollisionShape2D = $PistolHitBox/CollisionShape2D

var input_direction: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN
var is_attacking: bool = false
var can_attack: bool = true

const SPEED: float = 90.0
const ACCELERATION: float = 20.0
const ATTACK_COOLDOWN: float = 0.2

func _physics_process(_delta: float) -> void:
	var raw_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Snap to 4 cardinal directions only (no diagonals)
	if raw_input != Vector2.ZERO:
		facing_direction = get_cardinal_direction(raw_input)
		input_direction = facing_direction
	else:
		input_direction = Vector2.ZERO


func get_cardinal_direction(dir: Vector2) -> Vector2:
	if abs(dir.x) > abs(dir.y):
		return Vector2(sign(dir.x), 0)
	else:
		return Vector2(0, sign(dir.y))


func move(speed: float, acceleration: float, delta: float) -> void:
	if is_attacking:
		velocity = Vector2.ZERO
	else:
		velocity = lerp(velocity, input_direction * speed, acceleration * delta)


func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	print("Hit enemy:", area.name)
