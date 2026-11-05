@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name IdleState extends State
@export var walking_state: WalkingState
@export var jumping_state: JumpingState
func enter(oldState: State) -> void:
	additional_enter_logic(oldState)
	#parent.animations.play(animation_name)
	
	pass

func exit(newState: State) -> void:
	additional_exit_logic(newState)
	pass


func process_input(event: InputEvent) -> State:
	additional_process_input_logic(event)
	var raw_input: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") 
	if raw_input:
		return walking_state
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	additional_process_frame_logic(delta)
	
	return null

func process_physics(delta: float) -> State:
	additional_process_physics_logic(delta)
	return null
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
