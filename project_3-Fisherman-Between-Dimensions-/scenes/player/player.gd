extends Node2D

class_name PlayerCharacter

@export var fishing_rod: FishingRod

@export var min_cast_distance: float = 30.0
@export var max_cast_distance: float = 400.0
@export var cast_charge_speed: float = 200.0

var cast_distance: float = 0.0
var cast_direction: Vector2 = Vector2.ZERO
var charging_direction: float = 1.0
var is_charging: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hook"):
		if await fishing_rod.start_cast_charge():
			is_charging = true
			charging_direction = 1.0
			cast_distance = 0.0
	if event.is_action_released("hook"):
		if is_charging:
			is_charging = false
			var cast_position: Vector2 = (
				fishing_rod.global_position 
				+ cast_direction.normalized() 
				* cast_distance)
			fishing_rod.request_cast(cast_position)

func _process(delta: float) -> void:
	if !is_charging:
		return
	cast_direction = get_global_mouse_position()
	cast_distance += charging_direction * cast_charge_speed * delta
	if cast_distance >= max_cast_distance:
		cast_distance = max_cast_distance
		charging_direction = -1.0
	if cast_distance <= min_cast_distance:
		cast_distance = min_cast_distance
		charging_direction = 1.0
	print("cast_distance: ", cast_distance)
	
func check_rod_state():
	return fishing_rod.current_state
