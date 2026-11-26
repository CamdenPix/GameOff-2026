class_name AnimationRequester extends Node2D
@export var animated_sprite: AnimatedSprite2D 
var queue: Array[String]
var localanimal: ChildStateMachine
var old_animation: String

func request_animation(animation_name: String, state: State, animal: ChildStateMachine) -> void:
	localanimal = animal
	#if state is WalkingState and old_animation == 'Land':
		#queue.append("Walk")
		#old_animation = animation_name
		#return
	old_animation = animation_name
	animated_sprite.play(animation_name+ '-' + localanimal.name)


func _on_animated_sprite_2d_animation_finished() -> void:
	
	if queue.is_empty() == false:
		animated_sprite.play(queue[0]+ '-' + localanimal.name)
		queue.pop_front()
	pass # Replace with function body.
