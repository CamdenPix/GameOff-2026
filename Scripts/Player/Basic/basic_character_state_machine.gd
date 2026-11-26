@icon("res://assets/animal-footprint-svgrepo-com.svg")

extends ChildStateMachine
@export var bird: Bird
@export var sugarBear: SugarBear
@export var penguin: Penguin

func animal_process_physics(delta:float) -> ChildStateMachine:
	return
func animal_process_input(event: InputEvent) -> ChildStateMachine:
	if Input.is_action_just_pressed("up"):
		return bird
	if Input.is_action_just_pressed("left"):
		return sugarBear
	if Input.is_action_just_pressed("down"):
		return penguin
	return
func animal_process_frame(delta: float ) -> ChildStateMachine:
	return
