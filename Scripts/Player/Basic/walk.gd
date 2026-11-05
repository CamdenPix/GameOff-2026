@icon("res://assets/chip-svgrepo-com.svg")
@abstract
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
	
	var raw_input: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	if raw_input.length() == 0:
		return 
	var velocity_difference = abs(parent.velocity.x *raw_input.x) - animal.Ground_Max_Speed
	#print(velocity_difference)
	
	# Ignore player at max speed
	if velocity_difference == 0:
		return
		
		
	# We speed up the player to get closer to max speed
	if velocity_difference < 0:
		
		var time_left_normalized = 1 - easeOutQuart(abs(parent.velocity.x *raw_input.x)/ animal.Ground_Max_Speed)
		print("t left norm: ", time_left_normalized)
		var time_left= animal.Ground_Accleration_Time * time_left_normalized
		print('t_left: ', time_left)
		#var time: int = Time.get_ticks_msec()
		
		var accel = easeOutQuart((time_left - delta) / animal.Ground_Accleration_Time)
	
		print("accel: ", accel)
		parent.velocity.x += accel * raw_input.x
		#print(easeOutQuart(t))
		#var mapped_out_accel = 1 - easeOutQuart(t)
		#var mapped_out_accel * 
		return
		
	# Slow player down to max speed
	if velocity_difference > 0:
		return
	
	var temp_speed = parent.velocity.x 
	additional_move_logic(delta)

func easeOutQuart(x: float) -> float:
	return 1 - pow(1 - x, 4);

func easeOutExpo(x: float) -> float:
	if x == 1:
		return 1
	
	return 1 - pow(2, -10 * x);

@abstract func additional_move_logic(delta:float) -> void
@abstract func additional_exit_logic(newState: State) -> void
@abstract func additional_enter_logic(oldState: State) -> void
@abstract func additional_process_physics_logic(delta:float) -> State
@abstract func additional_process_frame_logic(delta:float) -> State
@abstract func additional_process_input_logic(event: InputEvent) -> State
