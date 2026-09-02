extends Node2D
class_name Bubbler

var bubbler_default_position: Vector2
var bubbler_throwed: bool = false

func _ready() -> void:
	bubbler_default_position = global_position

func throw_bubbler(cast_position: Vector2) -> void:
	print("bubbler_throwed")
	bubbler_throwed = true
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
		self,"global_position",bubbler_default_position,0.5
	)
	await tween.finished
