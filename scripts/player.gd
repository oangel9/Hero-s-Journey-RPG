extends CharacterBody2D
class_name Player

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colshape: CollisionShape2D = $SwordHitBox/CollisionShape2D
var input_direction = Vector2.ZERO
const SPEED = 60.0
const ATTACK_COOLDOWN: float = 0.2
var is_attacking: bool = false
var can_attack:  bool = true
#var atk_directions: Dictionary = {Vector2.LEFT : }

func _physics_process(delta: float) -> void:
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	print(input_direction)
	
func move(speed: float, acceleration: float, delta: float) -> void:
	velocity = lerp(velocity, input_direction * speed, acceleration * delta)


func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	print("we hit the eny")
