extends Node2D
class_name FishingRod

enum RodStates {
	IDLE,
	CHARGING,
	CASTING,
	WAITING,
	REELING,
	CAUGHT,
	FAILED
}

@export var bobber: Bobber

var current_state: RodStates = RodStates.IDLE

func _ready() -> void:
	SignalBus.event_started.connect(_on_event_started)

func _on_event_started(_fish_behavior):
	return
	set_state(RodStates.REELING)
	# player inputs now affects stats and used during minigame
	# stats:
	# fishing line lenght - if bobber went too far - end event
	# fishing line endurance - if draw while fish in running state
	# line endurance will lower - if too low line breaks
	# stamina - if player ran out of stamina - cant affect game
	

func start_cast_charge() -> bool:
	if current_state == RodStates.CASTING:
		print("rod_is_busy")
		return false
	
	if current_state == RodStates.WAITING:
		print("rod_set_idle")
		await bobber.set_default_position()
		set_state(RodStates.IDLE)
		return false
	
	if current_state != RodStates.IDLE:
		return false
	set_state(RodStates.CHARGING)
	print("rod_charging")
	return true

func request_cast(cast_position: Vector2):
	if current_state != RodStates.CHARGING:
		return
	set_state(RodStates.CASTING)
	await bobber.throw_bobber(cast_position)
	if !bobber.check_collision():
		print("not_in_lake")
		await bobber.set_default_position()
		set_state(RodStates.IDLE)
		return
	set_state(RodStates.WAITING)

func set_state(new_state: RodStates):
	if current_state == new_state:
		return
	current_state = new_state
	SignalBus.fishing_rod_state.emit(current_state)
