extends Node2D
class_name FishingArea

func _ready() -> void:
	# this project contains only one lake so this code is okay
	# if there will be multiple lakes - game manager should select
	GameManager.current_fishing_area = self

func contains_point(point: Vector2):
	var shape: CircleShape2D = $fishing_area2d/fishing_collision.shape as CircleShape2D
	var radius: float = shape.radius * global_scale.x
	
	return global_position.distance_to(point) <= radius
