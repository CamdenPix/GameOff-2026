@icon("res://assets/chip-svgrepo-com.svg")
class_name FallingState extends State

@export var landing_state: LandingState
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	#parent.velocity.y =0
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var raw_input: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") 
	parent.velocity.x = raw_input.x * animal.Speed
	parent.velocity.y += animal.Fall_Gravity
	if parent.is_on_floor():
		return landing_state
	return null
