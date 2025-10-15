extends Control

@export var heart_full: Texture2D
@export var heart_empty: Texture2D
@export var heart_scene: PackedScene  # Optional — for new hearts
@export var max_hearts := 4 
var current_health := 4

@onready var hearts_container: HBoxContainer = $HealthMarginContainer/HeartsContainer

func _ready():
	update_heart_count()
	update_hearts()

func update_heart_count():
	var current_heart_count = hearts_container.get_child_count()

	# If player gained max HP, add new hearts dynamically
	while current_heart_count < max_hearts:
		var new_heart: TextureRect
		if heart_scene:
			new_heart = heart_scene.instantiate()
		else:
			new_heart = TextureRect.new()
			new_heart.texture = heart_empty
			new_heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

		hearts_container.add_child(new_heart)
		current_heart_count += 1

func update_hearts():
	var hearts = hearts_container.get_children()

	for i in range(hearts.size()):
		var heart = hearts[i]
		if i < current_health:
			heart.texture = heart_full
		else:
			heart.texture = heart_empty
		
func set_health(value: int):
	current_health = clamp(value, 0, max_hearts)
	update_hearts()

func set_max_health(value: int):
	max_hearts = max(value, 1)
	update_heart_count()
	update_hearts()
