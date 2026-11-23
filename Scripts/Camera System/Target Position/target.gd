@tool
class_name Target extends Node2D
#@onready var TARGET_SVGREPO_COM = preload("uid://cwadfvvej154j")

#@onready var sprite_2d: Sprite2D = $Sprite2D


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2(0,0), 8 ,Color.MINT_CREAM ,true)
		draw_circle(Vector2(0,0), 7 ,Color.BLACK ,true)
		draw_circle(Vector2(0,0), 6 ,Color.MINT_CREAM ,true)
		draw_circle(Vector2(0,0), 5 ,Color.BLACK ,true)
		draw_circle(Vector2(0,0), 4 ,Color.MINT_CREAM ,true)
		draw_circle(Vector2(0,0), 2 ,Color.BLACK ,true)
		draw_circle(Vector2(0,0), 1 ,Color.WHITE ,true)
