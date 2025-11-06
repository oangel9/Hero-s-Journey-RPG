extends State

@onready var player: CharacterBody2D = get_parent().get_parent()

func enter() -> void:
	player.is_attacking = true
	player.can_attack = false
	pistol_animation_player()
	print("swung!")
	# Start attack coroutine
	attack()

func physics_update(delta: float) -> void:
	# During attack, player shouldn't move or change states
	pass

func attack() -> void:
	print(player.facing_direction)
	pistol_hitbox_collider(player.facing_direction)
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
	
func pistol_hitbox_collider(direction: Vector2) -> void:
	match direction:
		Vector2.LEFT:
			player.sword_colshape.position = Vector2(0,0)
			player.pistol_colshape.rotation_degrees = 360
		Vector2.RIGHT:
			player.pistol_colshape.position = Vector2(0,0)
			player.pistol_colshape.rotation_degrees = 180
		Vector2.UP:
			player.pistol_colshape.position = Vector2(0, 4)
			player.pistol_colshape.rotation_degrees = 90
		Vector2.DOWN:
			#player.pistol_colshape.position = Vector2(0, 15)
			player.pistol_colshape.rotation_degrees = 270

func pistol_animation_player() -> void:
	match player.facing_direction:
		Vector2.LEFT:
			#review, but for now it works... 
			player.anim.flip_h = false
			player.anim.play("left_pistol_attack")
		Vector2.RIGHT:
			#player.anim.flip_h = false
			player.anim.play("left_pistol_attack")
		Vector2.UP:
			player.anim.play("up_pistol_attack")
		Vector2.DOWN:
			player.anim.play("down_pistol_attack")
