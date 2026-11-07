@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name JumpingState extends State

@export var falling_state: FallingState
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	additional_enter_logic(oldState)
	parent.velocity.y = -animal.Jump_Velocity
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
	
	return null
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
