@icon("res://assets/chip-svgrepo-com.svg")
class_name DashingState extends State

func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	
	pass

func exit(newState: State) -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var raw_input: Vector2 = Input.get_vector("left","right","up","down") 
	parent.velocity.x = raw_input.x * animal.Speed
	return null
