class_name Player extends CharacterBody2D
@export var parent_state_machine: ParentStateMachine


func _ready() -> void:
	parent_state_machine.init(self)
