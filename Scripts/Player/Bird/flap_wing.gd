@icon("res://assets/chip-svgrepo-com.svg")
class_name FlappingState extends State

@export var falling_state: FallingState
func enter(oldState: State) -> void:
	parent.velocity.y = -animal.Jump_Velocity
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if parent.velocity.y + animal.Jump_Gravity * delta < 0:
		parent.velocity.y += animal.Jump_Gravity * delta
		#print(Jump_Gravity, parent.velocity)
	else:
		return falling_state
	return null
