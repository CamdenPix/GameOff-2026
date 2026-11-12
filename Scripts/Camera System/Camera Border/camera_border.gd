@tool
class_name CameraBorder extends StaticBody2D

func _ready() -> void:
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	set_collision_layer_value(6, true)
