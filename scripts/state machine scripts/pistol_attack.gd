extends State

@onready var player: CharacterBody2D = get_parent().get_parent()

func enter() -> void:
	player.is_attacking = true
	player.can_attack = false
	player.anim.play("pistol_left_attack")
	print("swung!")
	# Start attack coroutine
	attack()

func physics_update(delta: float) -> void:
	# During attack, player shouldn't move or change states
	pass

func attack() -> void:
	await get_tree().create_timer(0.2).timeout
	player.pistol_colshape.disabled = false  # Enable hitbox

	await get_tree().create_timer(0.2).timeout
	player.pistol_colshape.disabled = true   # Disable hitbox again

	await player.anim.animation_finished
	player.is_attacking = false
	print("Attack finished!")

	await get_tree().create_timer(player.ATTACK_COOLDOWN).timeout
	player.can_attack = true

	# Go back to idle automatically
	state_machine.change_state("idle")
