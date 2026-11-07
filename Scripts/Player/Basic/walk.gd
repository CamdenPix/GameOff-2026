@icon("res://assets/chip-svgrepo-com.svg")
@abstract
class_name WalkingState extends State
@export var dash_threshold: float = .3
@export var dashing_state: DashingState
@export var jumping_state: JumpingState
@export var falling_state: FallingState
@export var coyote_timer: Timer
var coyote_timer_fall: bool = false
var speed_up_elapsed_time: float = 0.0
const accelerationExponent: int = 2

func enter(oldState: State) -> void:
	additional_enter_logic(oldState)
	speed_up_elapsed_time = get_progress()
	pass

func exit(newState: State) -> void:
	additional_exit_logic(newState)
	coyote_timer.stop()
	coyote_timer_fall = false
	pass

func process_input(event: InputEvent) -> State:
	additional_process_input_logic(event)
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	additional_process_frame_logic(delta)
	return null

func process_physics(delta: float) -> State:
	additional_process_physics_logic(delta)
	move(delta)
	#if abs(raw_input.x) > dash_threshold:
		#return dashing_state
	
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
	if raw_input.length() == 0:
		speed_up_elapsed_time -= delta
	var velocity_difference = abs(parent.velocity.x*raw_input.x) - animal.Ground_Max_Speed
		
	# Slow player down to max speed
	if velocity_difference > 0:
		speed_up_elapsed_time = animal.Ground_Accleration_Time
		print('slow downnn')
		#var direction = parent.velocity.x / parent.velocity.x
		if parent.velocity.x > 0:
			parent.velocity.x -= animal.Ground_Past_Max_Speed_Decceleration
		else:
			parent.velocity.x += animal.Ground_Past_Max_Speed_Decceleration
	
	# We speed up the player to get closer to max speed
	if velocity_difference < 0:
		speed_up_elapsed_time += delta
		var time_left = animal.Ground_Accleration_Time - speed_up_elapsed_time
		var progress = clamp(speed_up_elapsed_time / animal.Ground_Accleration_Time, 0.0, 1.0)
		var smooth_progress = easingFunctions.easeOutQuart(progress, accelerationExponent)
		var smooth_speed = smooth_progress * animal.Ground_Max_Speed
		var difference = (smooth_speed * raw_input.x) - parent.velocity.x
		parent.velocity.x += difference
		
	return

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
