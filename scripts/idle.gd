extends State

@onready var player: CharacterBody2D = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	if player.input_direction != Vector2.ZERO:
		state_machine.change_state("move")
	
	player.anim.play("idle")
	player.move(0,15,delta)
	player.move_and_slide()
