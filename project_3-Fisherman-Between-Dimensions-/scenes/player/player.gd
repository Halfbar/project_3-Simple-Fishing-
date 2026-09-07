extends Node2D

class_name PlayerCharacter

@export var fishing_rod: FishingRod

@export var cast_charge_speed: float = 200.0

enum PlayerStates {
	IDLE,
	CHARGING,
	REELING
}
var player_current_state: PlayerStates

var min_cast_distance: float
var max_cast_distance: float
var cast_distance: float = 0.0
var cast_direction: Vector2 = Vector2.ZERO
var charging_direction: float = 1.0

func _ready() -> void:
	min_cast_distance = fishing_rod.get_fishing_min_radius()
	max_cast_distance = fishing_rod.get_fishing_max_radius()
	player_current_state = PlayerStates.IDLE

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hook"):
		if await fishing_rod.start_cast_charge():
			player_current_state = PlayerStates.CHARGING
			charging_direction = 1.0
			cast_distance = 0.0
	if event.is_action_released("hook"):
		if player_current_state == PlayerStates.CHARGING:
			player_current_state = PlayerStates.IDLE
			var cast_position: Vector2 = (
				fishing_rod.global_position 
				+ cast_direction.normalized() 
				* cast_distance)
			fishing_rod.request_cast(cast_position)
	if event.is_action_pressed("reel"):
		player_current_state = PlayerStates.REELING
	if event.is_action_released("reel"):
		player_current_state = PlayerStates.IDLE
		fishing_rod.stop_reeling()

func _process(delta: float) -> void:
	match player_current_state:
		PlayerStates.REELING:
			fishing_rod.reel(delta)
		PlayerStates.CHARGING:
			cast_direction = get_global_mouse_position() - fishing_rod.global_position
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
