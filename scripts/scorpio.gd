extends CharacterBody2D

@export var speed: float = 40.0       # movement speed
@export var patrol_distance: float = 100.0  # how far it moves from start
var start_position: Vector2
var direction: int = 1   # 1 = right, -1 = left
var hitable_cooldown: float = .5
var can_hit = true

@onready var anim: AnimatedSprite2D = $ScorpioAnim
@onready var hurtbox: HurtBox = $HurtBox

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
	hitable_cooldown = false
	#await anim.animation_finished
	hitable_cooldown = true
	
	print("This swung bro!")
