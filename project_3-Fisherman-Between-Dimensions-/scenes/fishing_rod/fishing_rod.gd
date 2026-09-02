extends Node2D
class_name FishingRod

enum RodStates {
	IDLE,
	CHARGING,
	CASTING,
	WAITING,
	BITING,
	REELING,
	CAUGHT,
	FAILED
}

@export var bubbler: Bubbler

var current_state: RodStates = RodStates.IDLE

func start_cast_charge() -> bool:
	if current_state == RodStates.CASTING:
		print("rod_is_busy")
		return false
	
	if current_state == RodStates.WAITING:
		print("rod_set_idle")
		await bubbler.set_default_position()
		current_state = RodStates.IDLE
		return false
	
	if current_state != RodStates.IDLE:
		return false
	current_state = RodStates.CHARGING
	print("rod_charging")
	return true

func request_cast(cast_position: Vector2):
	if current_state != RodStates.CHARGING:
		return
	if GameManager.current_fishing_area.contains_point(cast_position):
		print("not_in_lake")
		current_state = RodStates.IDLE
		return
	current_state = RodStates.CASTING
	await bubbler.throw_bubbler(cast_position)
	current_state = RodStates.WAITING
#func request_cast(cast_position: Vector2):
	#if current_state == RodStates.REELING or current_state == RodStates.CASTING:
		#print("rod_is_busy")
		#return
	## send bubbler
	#if current_state == RodStates.WAITING:
		#print("rod_set_idle")
		#await bubbler.set_default_position()
		#current_state = RodStates.IDLE
		#return
	#if !GameManager.current_fishing_area.contains_point(cast_position):
		#print("not_in_lake")
		#return
	#print("rod_set_waiting")
	#current_state = RodStates.CASTING
	#await bubbler.throw_bubbler(cast_position)
	#current_state = RodStates.WAITING
