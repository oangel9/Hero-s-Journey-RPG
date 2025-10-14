extends State

@onready var player: CharacterBody2D = get_parent().get_parent()

#@onready var anim = $"../../AnimatedSprite2D"

func _physics_process(delta: float) -> void:
	
	if player.input_direction == Vector2.ZERO:
		state_machine.change_state("idle")
	elif player.input_direction != Vector2.ZERO and player.can_attack == true:
		state_machine.change_state("move")
	
	if Input.is_action_just_pressed("attack") and player.can_attack:
		attack()
		return	
	


func attack() -> void:
	player.is_attacking = true
	player.can_attack = false 
	player.anim.play("left_sword_swing")
	print("swung!")
	await get_tree().create_timer(0.2).timeout
	player.colshape.disabled = false
	await get_tree().create_timer(0.2).timeout
	player.colshape.disabled = true
	
	#velocity = Vector2.ZERO
	await player.anim.animation_finished
	player.is_attacking = false
	print("Attack finished!")
	await get_tree().create_timer(player.ATTACK_COOLDOWN).timeout
	player.can_attack = true
