extends Node2D
class_name Bobber

@onready var bobber_area_2d: Area2D = $bobber_area2d

var bobber_default_position: Vector2
var bobber_throwed: bool = false

func _ready() -> void:
	bobber_default_position = global_position
	SignalBus.event_started.connect(_on_event_started)

func _on_event_started(fish_behavior: FishResource):
	return
	# load behaviour from fish_behaviour and start game

func throw_bobber(cast_position: Vector2) -> void:
	print("bubbler_throwed")
	bobber_throwed = true
	# thow to new position
	# when event starts 
	# bubbler area2d must collide with player area2d to catch fish
	# else fishing fails
	var tween: Tween = create_tween()
	tween.tween_property(
		self,"global_position",cast_position,0.5
	)
	await tween.finished

func set_default_position():
	print("bubbler_set_default")
	var tween: Tween = create_tween()
	tween.tween_property(
		self,"global_position",bobber_default_position,0.2
	)
	await tween.finished
	
func check_collision() -> bool:
	if bobber_area_2d.get_overlapping_areas():
		return true
	return false
