@icon("res://assets/animal-footprint-svgrepo-com.svg")

class_name Penguin extends ChildStateMachine

@export var additional_horizontal_boost: float = 20
@export var sugar_glider: SugarGlider
@export var animation: AnimationRequester
func enter(oldStateMachine: State) ->void:
	animation.request_animation(current_state.animation_name, current_state, self)
	var raw_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).limit_length(1.0)
	#if raw_input.x != 0:
		#parent.velocity.x += additional_horizontal_boost * raw_input.x
	pass

func animal_process_physics(delta:float) -> ChildStateMachine:
	if Input.is_action_just_pressed("swap_up_animal"):
		return sugar_glider
	return
func animal_process_input(event: InputEvent) -> ChildStateMachine:
	
	
	return
func animal_process_frame(delta: float ) -> ChildStateMachine:
	return
