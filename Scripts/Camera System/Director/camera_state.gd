@abstract
class_name CameraState
extends Node

@export var camera_man: CharacterBody2D
@export var camera: Camera2D
@export var parent: Player
var localOldState: State

func _ready() -> void:
	pass
func enter(oldState: CameraState) -> void:
	#parent.animations.play(animation_name)
	pass

func exit(newState: CameraState) -> void:
	pass

func process_frame(delta: float) -> CameraState:
	return null

func process_physics(delta: float) -> CameraState:
	return null
