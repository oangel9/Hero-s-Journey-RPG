extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var colshape = $HitBox/CollisionShape2D
const SPEED = 60.0
const ATTACK_COOLDOWN: float = 0.3
var is_attacking: bool = false
var can_attack:  bool = true

# Signals 
signal enemy_hit(enemy)


func _ready() -> void:
	colshape.disabled = true
	anim.connect("frame_changed", Callable(self, "_on_frame_changed"))
	anim.connect("frame_finished", Callable(self, "_on_frame_finished"))

func _physics_process(delta: float) -> void:
	
	if is_attacking:
		return
	
	if Input.is_action_just_pressed("attack") and can_attack:
		attack()
		return	
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	
	# Handle animation
		
	if direction == Vector2.ZERO:
		anim.play("idle")
	else:
		# Horizontal movement
		if abs(direction.x) > 0:
			anim.play("walking_left")
			anim.scale.x = -1 if direction.x > 0 else 1
		# Vertical movement
		elif direction.y != 0:
			if direction.y > 0:
				anim.play("walking_down")
			else:
				anim.play("walking_up")

func attack() -> void:
	is_attacking = true
	can_attack = false 
	anim.play("left_sword_swing")
	await get_tree().create_timer(0.2).timeout
	colshape.disabled = false
	await get_tree().create_timer(0.2).timeout
	colshape.disabled = true
	
	#velocity = Vector2.ZERO
	await anim.animation_finished
	is_attacking = false
	print("Attack finished!")
	await get_tree().create_timer(ATTACK_COOLDOWN).timeout
	can_attack = true

func move() -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	

func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	print("we hit the eny")
	
func _on_frame_changed():
	pass
	#if anim.animation == ""
