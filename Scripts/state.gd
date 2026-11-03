@abstract
class_name State
extends Node

@export
var animation_name: String
@export
var custom_animation_logic: bool = false

@export_category("Movement Parameters")
@export var Jump_Peak_Time: float = .5
@export var Jump_Fall_Time: float = .5
@export var Jump_Height: float = 2.0
@export var Jump_Distance: float = 4.0
@export var Jump_Release_Shorthop:float = .6



var Speed: float = 5.0
var Jump_Velocity: float = 5.0
var Jump_Gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var Fall_Gravity: float = 5.0
@export
var parent: CharacterBody3D
var localOldState: State


func _ready() -> void:
	Calculate_Movement_Parameters()
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
	return null

func Calculate_Movement_Parameters()->void:
	Jump_Gravity = (2*Jump_Height)/pow(Jump_Peak_Time,2)
	Fall_Gravity = (2*Jump_Height)/pow(Jump_Fall_Time,2)
	Jump_Velocity = Jump_Gravity * Jump_Peak_Time
	Speed = Jump_Distance/(Jump_Peak_Time+Jump_Fall_Time)
