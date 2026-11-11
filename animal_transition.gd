class_name AnimalTransition extends Node

var from_animal: ChildStateMachine
var to_animal: ChildStateMachine

var bodies : Array[Node2D] = []

var area : Area2D
var raycast_distance_away_from_ground: RayCast2D
var parent: CharacterBody2D
var vertical_difference: float
var from_animal_vertical_offset: float

func _ready() -> void:
	## this looks fucking stupid but trust
	from_animal_vertical_offset = from_animal.animal_resource.shape.get_rect().size.y / 2

func _physics_process(delta: float) -> void:
	#print(area.position)
	### use the raycast to keep the distance away from the ground
	#area.position.y = parent.position.y +
	if raycast_distance_away_from_ground.is_colliding():
		
		var collision_point = raycast_distance_away_from_ground.get_collision_point()
		if collision_point:
			var y_distance = raycast_distance_away_from_ground.global_position.distance_to(collision_point)
			area.position.y =   (y_distance - vertical_difference) - from_animal_vertical_offset
			
	else:
		area.position.y = 0
	pass


func body_entered(body: Node2D) -> void:
	bodies.append(body)

func body_exited(body: Node2D) -> void:
	if bodies.has(body):
		bodies.erase(body)
		
