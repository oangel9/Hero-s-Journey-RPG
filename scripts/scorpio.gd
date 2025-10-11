extends CharacterBody2D

@export var speed: float = 40.0       # movement speed
@export var patrol_distance: float = 100.0  # how far it moves from start
var start_position: Vector2
var direction: int = 1   # 1 = right, -1 = left

@onready var anim: AnimatedSprite2D = $ScorpioAnim

func _ready() -> void:
	start_position = global_position
	anim.play("left_walking")

func _physics_process(delta: float) -> void:
	# Move horizontally
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()

	# Flip when reaching patrol limit
	if abs(global_position.x - start_position.x) > patrol_distance:
		direction *= -1
		anim.flip_h = direction < 0   # flip sprite when changing dir


func take_damage(amount: int) -> void:
	anim.play("left_take_dmg")
	
	print("This swung bro!")
