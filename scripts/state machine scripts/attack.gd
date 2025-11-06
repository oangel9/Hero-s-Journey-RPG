extends State

@onready var player: Player = get_parent().get_parent()

func enter() -> void:
	player.is_attacking = true
	player.can_attack = false
	sword_animation_player()
	print("Swung!")
	#call_deferred("attack")  # Run attack coroutine properly
	attack()


func physics_update(_delta: float) -> void:
	# Disable movement and state changes during attack
	pass


func attack() -> void:
	print("Attack coroutine started, facing:", player.facing_direction)
	print(player.facing_direction)
	# Position hitbox based on direction
	sword_hitbox_collider(player.facing_direction)
	
	await get_tree().create_timer(0.15).timeout
	player.sword_colshape.disabled = false  # Enable hitbox

	await get_tree().create_timer(0.15).timeout
	player.sword_colshape.disabled = true   # Disable hitbox again

	# Wait for animation to finish
	await player.anim.animation_finished
	print("Attack finished!")

	player.is_attacking = false

	# Wait for cooldown before re-enabling attack
	await get_tree().create_timer(player.ATTACK_COOLDOWN).timeout
	player.can_attack = true

	# Return to idle
	state_machine.change_state("idle")


func sword_hitbox_collider(direction: Vector2) -> void:
	match direction:
		Vector2.LEFT:
			player.sword_colshape.position = Vector2(-15, 0)
		Vector2.RIGHT:
			# Center is 2 pixels shifted on to the left, to compensate the flip, we do 2 pixels to the right here
			player.sword_colshape.position = Vector2(17, 0)
		Vector2.UP:
			player.sword_colshape.position = Vector2(0, -15)
		Vector2.DOWN:
			player.sword_colshape.position = Vector2(0, 15)


func sword_animation_player() -> void:
	match player.facing_direction:
		Vector2.LEFT:
			#review, but for now it works... 
			player.anim.flip_h = false
			player.anim.play("left_sword_attack")
		Vector2.RIGHT:
			#player.anim.flip_h = false
			player.anim.play("left_sword_attack")
		Vector2.UP:
			player.anim.play("up_sword_attack")
		Vector2.DOWN:
			player.anim.play("down_sword_attack")
