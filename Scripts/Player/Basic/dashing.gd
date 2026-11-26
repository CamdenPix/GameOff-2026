@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name DashingState extends State
@export var dashing_time: Timer
@export var walkingState: WalkingState
@export var falling_state: FallingState
@export var dash_speed: float = 350.0
var direction: String
var timerTimedout: bool

func enter(oldState: State) -> void:
	additional_enter_logic(oldState)
	var raw_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).limit_length(1.0)
	var direction = 0
	if raw_input.length() == 0:
		direction = 1
	else:
		direction = 1 if raw_input.x > 0 else -1
	parent.velocity.x = dash_speed * direction
	parent.velocity.y = 0
	dashing_time.start()
	dashing_time.one_shot = true
	timerTimedout = false
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
	

	if(timerTimedout):
		if parent.is_on_floor():
			return walkingState
		else:
			return falling_state
	
	return null



	return null

func _on_timer_timeout() -> void:
	timerTimedout = true
	pass

@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
