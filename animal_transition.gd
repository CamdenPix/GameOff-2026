class_name AnimalTransition extends Node

var from_animal: ChildStateMachine
var to_animal: ChildStateMachine

var left_bodies : Array[Node2D] = []
var right_bodies : Array[Node2D] = []

var left_area : Area2D
var right_area : Area2D


func left_body_entered(body: Node2D) -> void:
	left_bodies.append(body)

func left_body_exited(body: Node2D) -> void:
	if left_bodies.has(body):
		left_bodies.erase(body)
		
func right_body_exited(body: Node2D) -> void:
	if right_bodies.has(body):
		right_bodies.erase(body)
	
func right_body_entered(body: Node2D) -> void:
	right_bodies.append(body)
