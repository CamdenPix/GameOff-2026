class_name Player extends CharacterBody2D
@onready var velocity_label: Label = $VelocityLabel
@onready var parent_state_machine: ParentStateMachine = $ParentStateMachine
@onready var camera_state_machine: CameraStateMachine = $Director/StateMachine
@onready var target_position_state: TargetPositionState = $Director/StateMachine/TargetPosition

func _ready() -> void:
	parent_state_machine.init(self)
	
func _physics_process(delta: float) -> void:
	var text_velocity: String = "X: " + str(velocity.x) + "\n Y:" + str(velocity.y)
	velocity_label.text =  text_velocity
	parent_state_machine.process_physics(delta)
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	parent_state_machine.process_input(event)

func _process(delta: float) -> void:
	parent_state_machine.process_frame(delta)
	
func target_camera_position(target_position:Vector2):
	target_position_state.target_position = target_position
	camera_state_machine.change_state(target_position_state)

func return_camera_state_machine_to_default():
	camera_state_machine.change_state(camera_state_machine.base_state)
