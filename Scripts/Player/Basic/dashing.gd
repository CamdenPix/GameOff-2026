@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name DashingState extends State

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
	var raw_input: Vector2 = Input.get_vector("left","right","up","down") 
	parent.velocity.x = raw_input.x * animal.Speed
	return null
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
