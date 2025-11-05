extends State

@onready var player: CharacterBody2D = get_parent().get_parent()

func enter() -> void:
	if player and player.anim:
		player.anim.play("idle")
		player.velocity = Vector2.ZERO

func physics_update(delta: float) -> void:
	# Check if the player gives movement input
	if player.input_direction != Vector2.ZERO:
		state_machine.change_state("move")
	elif Input.is_action_just_pressed("attack") and player.can_attack:
		state_machine.change_state("attack")
		return
	elif Input.is_action_just_pressed("pistol_attack") and player.can_attack:
		state_machine.change_state("pistol_attack")
		return
	
	# Apply gravity or standing movement if needed
