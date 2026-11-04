@icon("res://assets/chip-svgrepo-com.svg")
extends State

@export var landing_state: State
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	parent.velocity.y =0
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += Fall_Gravity
	if parent.is_on_floor():
		return landing_state
	return null
