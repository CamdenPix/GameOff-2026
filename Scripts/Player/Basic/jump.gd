@icon("res://assets/chip-svgrepo-com.svg")
extends State

@export var falling_state: State
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	parent.velocity.y = -Jump_Velocity
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if parent.velocity.y + Jump_Gravity * delta < 0:
		parent.velocity.y += Jump_Gravity * delta
		#print(Jump_Gravity, parent.velocity)
	else:
		return falling_state
	
	return null
