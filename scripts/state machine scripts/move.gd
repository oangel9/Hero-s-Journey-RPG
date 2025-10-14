extends State

@onready var player: CharacterBody2D = get_parent().get_parent()
#@onready var anim = $"../../AnimatedSprite2D"

func _physics_process(delta: float) -> void:
	
	if player.input_direction == Vector2.ZERO:
		state_machine.change_state("idle")
	elif Input.is_action_just_pressed("attack") and player.can_attack:
		state_machine.change_state("attack")

	if abs(player.input_direction.x) > 0:
		#print("you are here")
		player.anim.play("walking_left")
		player.anim.scale.x = -1 if player.input_direction.x > 0 else 1
	# Vertical movement
	elif player.input_direction.y != 0:
		if player.input_direction.y > 0:
			player.anim.play("walking_down")
		else:
			player.anim.play("walking_up")
			
	player.move(90,20,delta)
	player.move_and_slide()
