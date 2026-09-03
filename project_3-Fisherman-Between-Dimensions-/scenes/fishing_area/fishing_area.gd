extends Node2D
class_name FishingArea

func _ready() -> void:
	# this project contains only one lake so this code is okay
	# if there will be multiple lakes - game manager should select
	GameManager.current_fishing_area = self
