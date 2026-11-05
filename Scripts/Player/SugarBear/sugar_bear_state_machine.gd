@icon("res://assets/animal-footprint-svgrepo-com.svg")

extends ChildStateMachine
@export var Bird: ChildStateMachine
func animal_process_physics(delta:float) -> ChildStateMachine:
	return
func animal_process_input(event: InputEvent) -> ChildStateMachine:
	if Input.is_action_just_pressed("up"):
		return Bird
	return
func animal_process_frame(delta: float ) -> ChildStateMachine:
	return
