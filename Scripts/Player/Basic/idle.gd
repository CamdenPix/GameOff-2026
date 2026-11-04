@icon("res://assets/chip-svgrepo-com.svg")
class_name IdleState extends State
@export var walking_state: WalkingState
@export var jumping_state: JumpingState
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	var raw_input: Vector2 = Input.get_vector("left","right","up","down") 
	if raw_input:
		return walking_state
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	
	return null
