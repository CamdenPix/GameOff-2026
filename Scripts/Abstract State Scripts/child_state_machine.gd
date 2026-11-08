
@abstract
class_name ChildStateMachine extends State

@export var animal_changer: AnimalChanger


####################
###		Don't put abstract states as a explict type for godot in signals. 
###		Idk why but it doesnt work
#######################
signal animal_request(current_animal, new_animal)

@export var animal_resource: Animal_Resource

@export 
var debug_state_label : Label

@export
var no_debug_labels: bool = false


@export_category("State Machine Base States")
@export
var starting_state: State

@export var deactive_state: State
@export var base_state: State
var localOldStateMachine: ChildStateMachine


@export_category("Movement Parameters")
@export var Jump_Peak_Time: float = .5
@export var Jump_Fall_Time: float = .5
@export var Jump_Height: float = 2.0
@export var Jump_Distance: float = 4.0
@export var Jump_Release_Shorthop:float = .6

@export var Ground_Acceleration_Time: float = 3.0
# How many times faster decceleration is
@export var Ground_Decceleration_Ratio: float = 3.0
@export var Ground_Max_Speed: float = 200.0
@export var Ground_Past_Max_Speed_Decceleration: float = 40
@export var Ground_Speed_Curve: Curve


var AirSpeed: float = 7.5
var MaxAirSpeed: float = 50.0
var Jump_Velocity: float = 5.0
var Jump_Gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var Fall_Gravity: float = 5.0
var Ground_Acceleration: float = 20.0

#0,.8,.53,1

var current_state: State

func _ready() -> void:
	if debug_state_label == null and no_debug_labels == true:
		push_error(self.name + ': Hey man the debug state label or no debug label needs to be set')
	animal = null
	Calculate_Movement_Parameters()

func enter(oldStateMachine: State) ->void:
	localOldStateMachine = oldStateMachine
	pass

func exit(newStateMachine: State) ->void:
	pass

func init(parent: Player) -> void:
	remote_view_animal_name = self.name
	for child in get_children():
		child.parent = parent
		child.animal = self

	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit(new_state)
	var old_state = current_state
	current_state = new_state
	
	if new_state == null:
		push_error('animal: ' + self.name + 'had a new state be null. if this happened at start of the game check if starting state, deactive state and base state are set')
	if no_debug_labels == false:
		debug_state_label.text = new_state.to_string()
	current_state.enter(old_state)


func process_physics(delta: float) -> ChildStateMachine:
	
	var new_state = current_state.process_physics(delta)
	if new_state is State:
		change_state(new_state)
	var new_animal = animal_process_physics(delta)
	if new_animal is ChildStateMachine:
		return new_animal
	return

func process_input(event: InputEvent) -> ChildStateMachine:
	
	var new_state = current_state.process_input(event)

	if new_state is State:
		change_state(new_state)
	var new_animal = animal_process_input(event)
	if new_animal is ChildStateMachine:
		return new_animal
	return

func process_frame(delta: float) -> ChildStateMachine:
	var new_state = current_state.process_frame(delta)
	if new_state is State:
		change_state(new_state)
	
	var new_animal = animal_process_frame(delta)
	if new_animal is ChildStateMachine:
		return new_animal
	return


func Calculate_Movement_Parameters()->void:
	Jump_Gravity = (2*Jump_Height)/pow(Jump_Peak_Time,2)
	Fall_Gravity = (2*Jump_Height)/pow(Jump_Fall_Time,2)
	Jump_Velocity = Jump_Gravity * Jump_Peak_Time
	AirSpeed = Jump_Distance/(Jump_Peak_Time+Jump_Fall_Time)

@abstract func animal_process_physics(delta:float) -> ChildStateMachine
@abstract func animal_process_input(event: InputEvent) -> ChildStateMachine
@abstract func animal_process_frame(delta: float ) -> ChildStateMachine
