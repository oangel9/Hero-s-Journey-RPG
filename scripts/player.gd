extends CharacterBody2D
class_name Player

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var input_direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
func move(speed: float, acceleration: float, delta: float) -> void:
	velocity = lerp(velocity, input_direction * speed, acceleration * delta)
