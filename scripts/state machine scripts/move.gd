extends State

@onready var player: Player = get_parent().get_parent()

func enter() -> void:
	play_move_animation()


func physics_update(delta: float) -> void:
	# Handle transitions first
	if player.input_direction == Vector2.ZERO:
		state_machine.change_state("idle")
		return
	elif Input.is_action_just_pressed("attack") and player.can_attack:
		state_machine.change_state("attack")
		return
	elif Input.is_action_just_pressed("pistol_attack") and player.can_attack:
		state_machine.change_state("pistol_attack")
		return

	# Update facing direction (still snapped to 4 ways)
	player.facing_direction = player.get_cardinal_direction(player.input_direction)

	# Flip or switch animation if needed
	play_move_animation()

	# Perform actual movement
	player.move(player.SPEED, player.ACCELERATION, delta)
	player.move_and_slide()


func play_move_animation() -> void:
	# Choose correct walking animation for 4 directions
	match player.facing_direction:
		Vector2.LEFT:
			player.anim.play("walking_left")
			player.anim.scale.x = 1  # reset just in case
		Vector2.RIGHT:
			player.anim.play("walking_left")  # reuse same anim flipped
			player.anim.scale.x = -1
		Vector2.UP:
			player.anim.play("walking_up")
		Vector2.DOWN:
			player.anim.play("walking_down")
