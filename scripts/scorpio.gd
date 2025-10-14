extends CharacterBody2D

@export var speed: float = 30.0
@export var patrol_distance: float = 100.0
@export var accel: float = 8.0            # how quickly velocity approaches desired
@export var target_tolerance: float = 6.0 # how close before picking a new target

@onready var anim: AnimatedSprite2D = $ScorpioAnim

var start_position: Vector2
var target_position: Vector2
#var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	randomize()
	start_position = global_position
	_pick_new_target()
	anim.play("idle")

func _physics_process(delta: float) -> void:
	_move_towards_target(delta)

func _move_towards_target(delta: float) -> void:
	var to_target: Vector2 = target_position - global_position
	var dist := to_target.length()

	# If reached target (or got stuck), pick a new one
	if dist <= target_tolerance:
		_pick_new_target()
		return

	# Desired velocity toward the target
	var desired: Vector2 = to_target.normalized() * speed

	# Smoothly change velocity (Vector2 linear_interpolate is safe)
	velocity = velocity.lerp(desired, clamp(accel * delta, 0.0, 1.0))

	# Apply movement. CharacterBody2D uses its `velocity` property conventionally, but
	# move_and_slide() will use the local `velocity` variable if you pass it or you can
	# set self.velocity and call move_and_slide(). Here we'll use move_and_slide(velocity).
	move_and_slide()

	# Flip sprite based on horizontal movement (optional)
	if abs(velocity.x) > 1.0:
		anim.flip_h = velocity.x < 0

func _pick_new_target() -> void:
	# Pick a random direction and distance within a circle of radius patrol_distance
	var angle := randf() * TAU
	var r := randf_range(patrol_distance * 0.4, patrol_distance) # avoid too-small steps
	var offset := Vector2(abs(cos(angle)), abs(sin(angle))) * r
	target_position = start_position + offset
	# Debug:
	# print("New target:", target_position)
