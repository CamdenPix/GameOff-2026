@icon("res://assets/chip-svgrepo-com.svg")
class_name LandingState extends State
@export var idle_timer: Timer
@export var idle_state: IdleState
@export var walking_state: WalkingState
var return_idle_state: State

func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	idle_timer.start()
	pass

func exit(newState: State) -> void:
	idle_timer.stop()
	return_idle_state = null
	pass

func process_input(event: InputEvent) -> State:
	var raw_input: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") 
	
	if raw_input:
		return walking_state
	else:
		parent.velocity.x = 0
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return return_idle_state



func _on_timer_timeout() -> void:
	return_idle_state = idle_state
	pass # Replace with function body.
