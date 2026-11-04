@icon("res://assets/chip-svgrepo-com.svg")
class_name WalkingState extends State
@export var dash_threshold: float = .3
@export var dashing_state: DashingState
@export var jumping_state: JumpingState
@export var falling_state: FallingState
@export var coyote_timer: Timer
var coyote_timer_fall: bool = false
func enter(oldState: State) -> void:
	#parent.animations.play(animation_name)
	
	pass

func exit(newState: State) -> void:
	coyote_timer.stop()
	coyote_timer_fall = false
	pass

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		print('jump')
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var raw_input: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") 
	parent.velocity.x = raw_input.x * Speed
	#if abs(raw_input.x) > dash_threshold:
		#return dashing_state
	
	if parent.is_on_floor():
		coyote_timer.stop()
		parent.velocity.y += Fall_Gravity * delta
	else:
		if coyote_timer_fall:
			return falling_state
		# this just makes sure the timer runs only if the timer hasnt started
		if coyote_timer.is_stopped():
			coyote_timer.start()
		
	return null


func _on_timer_timeout() -> void:
	coyote_timer_fall = true
	pass
	
