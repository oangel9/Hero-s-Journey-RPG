extends State

@onready var player: CharacterBody2D = get_parent().get_parent()

func enter() -> void:
	player.is_attacking = true
	player.can_attack = false
	player.anim.play("left_sword_swing")
	print("swung!")
	# Start attack coroutine
	attack()

func physics_update(delta: float) -> void:
	# During attack, player shouldn't move or change states
	pass

func attack() -> void:
	# Take player's current direction
	position_hitbox_collider(player.input_direction)
	
	await get_tree().create_timer(0.2).timeout
	player.sword_colshape.disabled = false  # Enable hitbox

	await get_tree().create_timer(0.2).timeout
	player.sword_colshape.disabled = true   # Disable hitbox again

	await player.anim.animation_finished
	player.is_attacking = false
	print("Attack finished!")

	await get_tree().create_timer(player.ATTACK_COOLDOWN).timeout
	player.can_attack = true
	# Go back to idle automatically
	state_machine.change_state("idle")


func position_hitbox_collider(direction: Vector2):
	if direction == Vector2.LEFT:
		player.sword_colshape.position = Vector2(-15,5)
	elif direction == Vector2.RIGHT:
		player.sword_colshape.position = Vector2(15,5)
	elif direction == Vector2.DOWN:
		player.sword_colshape.position = Vector2(0,15)
	elif direction == Vector2.UP:
		player.sword_colshape.position = Vector2(0,-15)
