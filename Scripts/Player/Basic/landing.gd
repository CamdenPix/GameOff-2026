@abstract
@icon("res://assets/chip-svgrepo-com.svg")
class_name LandingState extends State
@export var idle_timer: Timer
@export var idle_state: IdleState
@export var walking_state: WalkingState
var return_idle_state: State

func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	additional_enter_logic(oldState)
	idle_timer.start()
	pass

func exit(newState: State) -> void:
	additional_exit_logic(newState)
	idle_timer.stop()
	return_idle_state = null
	pass

func process_input(event: InputEvent) -> State:
	additional_process_input_logic(event)
	var raw_input: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") 
	
	if raw_input:
		return walking_state
	else:
		parent.velocity.x = 0
	return null

func process_frame(delta: float) -> State:
	additional_process_frame_logic(delta)
	return null

func process_physics(delta: float) -> State:
	additional_process_physics_logic(delta)
	return return_idle_state



func _on_timer_timeout() -> void:
	return_idle_state = idle_state
	pass # Replace with function body.
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
