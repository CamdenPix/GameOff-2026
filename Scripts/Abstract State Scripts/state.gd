@abstract
class_name State
extends Node

@export
var animation_name: String
@export
var custom_animation_logic: bool = false

var remote_view_animal_name: String
@export
var parent: CharacterBody2D
var localOldState: State
var animal: ChildStateMachine

func _ready() -> void:
	remote_view_animal_name = self.name

func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
