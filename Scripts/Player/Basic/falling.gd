@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name FallingState extends State

@export var landing_state: LandingState
func enter(oldState: State) -> void:
	additional_enter_logic(oldState)
	#parent.animations.play(animation_name)
	
	pass

func exit(newState: State) -> void:
	additional_exit_logic(newState)
	pass

func process_input(event: InputEvent) -> State:
	additional_process_input_logic(event)
	return null

func process_frame(delta: float) -> State:
	additional_process_frame_logic(delta)
	return null


func process_physics(delta: float) -> State:
	additional_process_physics_logic(delta)
	var raw_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).limit_length(1.0) 
	parent.velocity.x = raw_input.x * animal.AirSpeed
	parent.velocity.y += animal.Fall_Gravity * delta
	if parent.is_on_floor():
		return landing_state
	return null
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
