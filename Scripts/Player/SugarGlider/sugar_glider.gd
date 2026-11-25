@icon("res://assets/animal-footprint-svgrepo-com.svg")

class_name SugarGlider extends ChildStateMachine
@export var penguin: Penguin
@export var animation: AnimationRequester
func enter(oldStateMachine: State) ->void:
	print(current_state)
	animation.request_animation(current_state.animation_name, current_state, self)
	pass
func exit(newStateMachine: State) ->void:
	pass

func animal_process_physics(delta:float) -> ChildStateMachine:
	if Input.is_action_just_pressed("swap_right_animal"):
		return penguin
	return
func animal_process_input(event: InputEvent) -> ChildStateMachine:
	
	
	return
func animal_process_frame(delta: float ) -> ChildStateMachine:
	return
