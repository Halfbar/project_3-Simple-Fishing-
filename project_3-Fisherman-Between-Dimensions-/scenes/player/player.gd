extends Node2D

@export var fishing_rod: FishingRod

@export var min_cast_distance: float = 100.0
@export var max_cast_distance: float = 400.0
@export var cast_charge_speed: float = 300.0

var cast_distance: float = 0.0
var cast_direction: Vector2 = Vector2.ZERO
var charging_direction: float = 1.0
var is_charging: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hook"):
		if await fishing_rod.start_cast_charge():
			is_charging = true
			charging_direction = 1.0
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
	cast_direction = get_global_mouse_position() - fishing_rod.global_position
	cast_distance += charging_direction * cast_charge_speed * delta
	if cast_distance >= max_cast_distance:
		cast_distance = max_cast_distance
		charging_direction = -1.0
	if cast_distance <= min_cast_distance:
		cast_distance = min_cast_distance
		charging_direction = 1.0
	print("cast_distance: ", cast_distance)


#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("hook"):
		#if is_charging:
			#return
		#is_charging
		#print("player_hook")
		#var cast_direction: Vector2 = get_global_mouse_position()
		## insert a minigame if player can cast
		## call func in future
		#var cast_distance: float = 200.0 
		#var cast_position: Vector2 = fishing_rod.global_position + cast_direction.normalized() * cast_distance
		#fishing_rod.request_cast(cast_position)
