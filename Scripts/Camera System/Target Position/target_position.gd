@tool
class_name TargetPosition extends Area2D

@export var target: Target

signal control_camera( target_position:Vector2 )
var child_target: Target
var line: Line2D

func _ready() -> void:
	var screenshot_20261112_at_7_13_39_am: Sprite2D = $Screenshot20261112At7_13_39Am
	
	if Engine.is_editor_hint() == false:
		screenshot_20261112_at_7_13_39_am.visible = false

func _process(delta):
	if Engine.is_editor_hint():
		if target and line:
			#print('awsd')
			var position1 = line.to_local(global_position)
			var position2 = line.to_local(child_target.global_position)
			line.set_point_position(0, position1)
			line.set_point_position(1, position2 )



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		pass
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		pass
	pass # Replace with function body.


func _on_child_entered_tree(node: Node) -> void:
	for child in get_children():
		if child is Target:
			pass
	if node is Target:
		child_target = node
		for child in get_children():
			if child is Line2D:
				line = child
		if line == null:
			var gradient = Gradient.new()
			gradient.set_color( 0,   Color.MINT_CREAM )
			gradient.set_color( 1,   Color.WEB_GRAY )
			line = Line2D.new()
			#var position1 = line.to_local(global_position)
			var position2 = line.to_local(child_target.global_position)
			line.add_point(position)
			line.add_point(position2)
			
			#add_child(line)
			line.set_gradient(gradient)
			line.width = 3.0
			#line.width_curve
			add_fucking_line.call_deferred(line)
		

func add_fucking_line(line:Line2D):
	add_child(line)
	line.owner = get_tree().edited_scene_root


func _on_child_exiting_tree(node: Node) -> void:
	if node == target:
		child_target = null
		target = null
		if line:
			line.queue_free()
		
		#line = null
	#line = null
