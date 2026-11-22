@icon("res://assets/chip-svgrepo-com.svg")
@abstract
class_name WalkingState extends State
@export var dash_threshold: float = .3
@export var dashing_state: DashingState
@export var jumping_state: JumpingState
@export var falling_state: FallingState
@export var idle_state: IdleState
@export var idle_timer: Timer
@export var coyote_timer: Timer
var coyote_timer_fall: bool = false
var speed_up_elapsed_time: float = 0.0
const accelerationExponent: int = 2
var potiental_idle_state: State
var idle_started: bool = false

func enter(oldState: State) -> void:
	idle_started = false
	potiental_idle_state = null
	additional_enter_logic(oldState)
	speed_up_elapsed_time = get_progress()
	pass

func exit(newState: State) -> void:
	idle_started = false
	potiental_idle_state = null
	additional_exit_logic(newState)
	coyote_timer.stop()
	coyote_timer_fall = false
	pass

func process_input(event: InputEvent) -> State:
	var possible_state : State = additional_process_input_logic(event)
	if possible_state:
		return possible_state
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	var possible_state : State = additional_process_frame_logic(delta)
	if possible_state:
		return possible_state
	return null

func process_physics(delta: float) -> State:
	var possible_state : State = additional_process_physics_logic(delta)
	if possible_state:
		return possible_state
	move(delta)
	#if abs(raw_input.x) > dash_threshold:
		#return dashing_state
	
	if potiental_idle_state:
		return potiental_idle_state
	
	if parent.is_on_floor():
		coyote_timer.stop()
		parent.velocity.y += animal.Fall_Gravity * delta
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
	
func move(delta:float):
	additional_move_logic(delta)
	var raw_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).limit_length(1.0)
	var direction = 0
	if raw_input.length() == 0:
		if idle_started == false:
			idle_started = true
			idle_timer.start()
		speed_up_elapsed_time -= delta*animal.Ground_Decceleration_Ratio
		if speed_up_elapsed_time < 0:
			speed_up_elapsed_time = 0
		direction = 1 if parent.velocity.x > 0 else -1
	else:
		idle_started = false
		idle_timer.stop()
		speed_up_elapsed_time += delta
		if speed_up_elapsed_time > animal.Ground_Acceleration_Time:
			speed_up_elapsed_time = animal.Ground_Acceleration_Time
		direction = 1 if raw_input.x > 0 else -1
		
	# Set Speed
	if abs(parent.velocity.x) > animal.Ground_Max_Speed:
		if parent.velocity.x > 0:
			parent.velocity.x -= animal.Ground_Past_Max_Speed_Decceleration
		else:
			parent.velocity.x += animal.Ground_Past_Max_Speed_Decceleration
	else:
		var progress = speed_up_elapsed_time/animal.Ground_Acceleration_Time
		var easedProgress = easingFunctions.easeOutQuart(progress, accelerationExponent)
		parent.velocity.x = easedProgress * animal.Ground_Max_Speed * direction
	
	return

func _idle_timer_timeout() -> void:
	potiental_idle_state = idle_state

func get_progress() -> float:
	var difference = abs(parent.velocity.x) - animal.Ground_Max_Speed
	if difference > 0:
		return 1.0
	else:
		var value_noramlized = abs(parent.velocity.x) / animal.Ground_Max_Speed
		var y = easingFunctions.easeOutQuartInverse(value_noramlized, accelerationExponent)
		return y
	return 0.0

@abstract func additional_move_logic(delta:float) -> void
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
