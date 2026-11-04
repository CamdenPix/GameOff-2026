@icon("res://assets/chip-svgrepo-com.svg")
class_name LandingState extends State
@export var timer: Timer
@export var idle_state: State
@export var walking_state: State
var return_idle_state: State

func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	timer.start()
	pass

func exit(newState: State) -> void:
	timer.stop()
	return_idle_state = null
	pass

func process_input(event: InputEvent) -> State:
	var raw_input: Vector2 = Input.get_vector("left","right","up","down") 
	if raw_input:
		return walking_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return return_idle_state



func _on_timer_timeout() -> void:
	return_idle_state = idle_state
	pass # Replace with function body.
