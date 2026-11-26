@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name DashingState extends State

func enter(oldState: State) -> void:
	additional_enter_logic(oldState)
	pass

func exit(newState: State) -> void:
	additional_exit_logic(newState)
	pass

func process_input(event: InputEvent) -> State:
	additional_process_input_logic(event)
	return null

func process_frame(delta: float) -> State:

	var possible_state : State = additional_process_frame_logic(delta)
	if possible_state:
		return possible_state
	return null

func process_physics(delta: float) -> State:
	var possible_state : State = additional_process_physics_logic(delta)
	if possible_state:
		return possible_state
	
	

	if(timerTimedout):
		if parent.is_on_floor():
			return walkingState
		else:
			return falling_state
	additional_process_frame_logic(delta)
	return null


@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
