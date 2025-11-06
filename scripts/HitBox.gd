class_name HitBox
extends Area2D

@export var damage := 10

func _init() -> void:
	collision_layer = 2
	collision_mask = 0


#
#enum Entity {
	#PLAYER = 1,
	#ENEMY = 2,
	#NPC = 3,
	#OBJECT = 4
#}
