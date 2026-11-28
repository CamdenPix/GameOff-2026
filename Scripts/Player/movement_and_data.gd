class_name MovementAndData extends Node
@export var sprite: AnimatedSprite2D
@export var parent: CharacterBody2D
var speed_up_elapsed_time: float = 0.0
const accelerationExponent: int = 2
var potiental_idle_state: State
var idle_started: bool = false

func move(delta: float, animal:ChildStateMachine):
	var raw_input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).limit_length(1.0)
	#var direction = 0
	if raw_input.length() == 0:
		#if idle_started == false:
			#idle_started = true
			#idle_timer.start()
		speed_up_elapsed_time -= delta*animal.Ground_Decceleration_Ratio
		if speed_up_elapsed_time < 0:
			speed_up_elapsed_time = 0
		#direction = 1 if parent.velocity.x > 0 else -1
	else:
		if raw_input.x > 0:
			sprite.flip_h = false
		if raw_input.x < 0:
			sprite.flip_h = true
		idle_started = false
		#idle_timer.stop()
		speed_up_elapsed_time += delta
		if speed_up_elapsed_time > animal.Ground_Acceleration_Time:
			speed_up_elapsed_time = animal.Ground_Acceleration_Time
		#direction = 1 if raw_input.x > 0 else -1
		
	# Set Speed
	if abs(parent.velocity.x) > animal.Ground_Max_Speed:
		if parent.velocity.x > 0:
			parent.velocity.x -= animal.Ground_Past_Max_Speed_Decceleration
		else:
			parent.velocity.x += animal.Ground_Past_Max_Speed_Decceleration
	else:
		var progress = speed_up_elapsed_time/animal.Ground_Acceleration_Time
		var easedProgress = easingFunctions.easeOutQuart(progress, accelerationExponent)
		var smooth_speed = easedProgress * animal.Ground_Max_Speed
		var difference = (smooth_speed * raw_input.x) - parent.velocity.x
		parent.velocity.x += difference
		#parent.velocity.x = easedProgress * animal.Ground_Max_Speed * direction
	
	return
