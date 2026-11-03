@abstract
class_name ChildStateMachine extends State
@export 
var debug_state_label : Label

@export
var debug_input_label : Label

@export
var no_debug_labels: bool = false

@export
var starting_state: State

var current_state: State



@export var deactive_state: State
@export var base_state: State
var localOldStateMachine: ChildStateMachine

func enter(oldStateMachine: State) ->void:
	localOldStateMachine = oldStateMachine
	pass

func exit(newStateMachine: State) ->void:
	pass

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent

	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit(new_state)
	var old_state = current_state
	current_state = new_state
	if no_debug_labels == false:
		debug_state_label.text = new_state.to_string()
	current_state.enter(old_state)


func process_physics(delta: float) -> ChildStateMachine:
	
	var new_state_or_state_machine = current_state.process_physics(delta)
	if new_state_or_state_machine is State:
		change_state(new_state_or_state_machine)
	if new_state_or_state_machine is ChildStateMachine:
		return new_state_or_state_machine
	return

func process_input(event: InputEvent) -> ChildStateMachine:
	
	var new_state_or_state_machine = current_state.process_input(event)
	if no_debug_labels == false:
		debug_input_label.text = event.to_string()
	
	if new_state_or_state_machine is State:
		change_state(new_state_or_state_machine)
	if new_state_or_state_machine is ChildStateMachine:
		return new_state_or_state_machine
	return

func process_frame(delta: float) -> ChildStateMachine:
	var new_state_or_state_machine = current_state.process_frame(delta)
	if new_state_or_state_machine is State:
		change_state(new_state_or_state_machine)
	if new_state_or_state_machine is ChildStateMachine:
		return new_state_or_state_machine
	return
