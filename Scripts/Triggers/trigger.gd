@tool
@abstract
class_name PlayerTrigger extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, true)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		use_enter_trigger(body)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		use_exit_trigger(body)
	
@abstract func use_enter_trigger(body:Node2D) -> void
@abstract func use_exit_trigger(body:Node2D) -> void
