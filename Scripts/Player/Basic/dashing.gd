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
	var possible_state : State = additional_process_input_logic(event)
	if possible_state:
		return possible_state
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
	
	var raw_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).limit_length(1.0)
	parent.velocity.x = raw_input.x * animal.AirSpeed
	return null
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
