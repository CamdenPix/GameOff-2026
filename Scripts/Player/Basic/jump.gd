@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name JumpingState extends State

@export var falling_state: FallingState
@export var dashing_state: DashingState
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	additional_enter_logic(oldState)
	parent.velocity.y = -animal.Jump_Velocity
	pass

func exit(newState: State) -> void:
	additional_exit_logic(newState)
	pass

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("dash"):
		return dashing_state
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
		
	parent.velocity.x += raw_input.x*animal.AirSpeed*delta
	if raw_input.x > 0 && parent.velocity.x >= animal.MaxAirSpeed:
		parent.velocity.x = max(animal.MaxAirSpeed, parent.velocity.x)
		parent.velocity.x -= raw_input.x*animal.AirSpeed*delta
	elif raw_input.x < 0 && parent.velocity.x <= (-animal.MaxAirSpeed):
		parent.velocity.x = min(-animal.MaxAirSpeed, parent.velocity.x)
		parent.velocity.x -= raw_input.x*animal.AirSpeed*delta
	
	if parent.velocity.y + animal.Jump_Gravity * delta < 0:
		parent.velocity.y += animal.Jump_Gravity * delta
		#print(Jump_Gravity, parent.velocity)
	else:
		return falling_state
	
	return possible_state
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
