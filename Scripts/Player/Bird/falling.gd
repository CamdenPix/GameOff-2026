extends FallingState

@export var flapping_state: FlappingState

func additional_exit_logic(newState: State) -> void:
	return
func additional_enter_logic(oldState: State) -> void:
	return
func additional_process_physics_logic(delta:float) -> State:
	return
func additional_process_frame_logic(delta:float) -> State:
	return
func additional_process_input_logic(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return flapping_state
	return
