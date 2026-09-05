extends Node2D
class_name Bobber

@onready var bobber_area_2d: Area2D = $bobber_area2d

var bobber_default_position: Vector2

enum BobberStates {
	IDLE,
	WAITING,
	IN_ACTION,
	RECOVERY,
	FIGHTING,
	DASHING,
}
var bobber_current_state: BobberStates = BobberStates.IDLE

var current_fish: FishResource
var current_fish_action: FishAction
var action_time: float = 0.0
var current_action_index: int = -1

var fishing_started: bool

func _ready() -> void:
	bobber_default_position = global_position
	
	SignalBus.event_started.connect(_on_event_started)
	SignalBus.fishing_rod_state.connect(_on_fishing_rod_state)

func _process(delta: float) -> void:
	if !fishing_started:
		return
	action_time -= delta
	match bobber_current_state:
		BobberStates.RECOVERY:
			process_recovery(delta)
		BobberStates.FIGHTING:
			process_moving(delta)
		BobberStates.DASHING:
			process_moving(delta)
	if action_time <= 0.0:
		set_next_action()

func process_recovery(_delta: float) -> void:
	print("fish_recovery")
	pass

func process_moving(delta: float) -> void:
	print("fish_moving")
	var direction := global_position.direction_to(bobber_default_position)
	direction = -direction
	global_position += direction * current_fish_action.strength * delta

func _on_fishing_rod_state(rod_current_state: FishingRod.RodStates):
	if rod_current_state == FishingRod.RodStates.FAILED:
		set_default_position()
		return
	if rod_current_state == FishingRod.RodStates.CAUGHT:
		set_default_position()
		return

func move_to_rod(delta) -> void:
	if global_position == bobber_default_position:
		return
	var pull_force: float = 70
	var direction: Vector2 = global_position.direction_to(bobber_default_position)
	global_position += direction * pull_force * delta

func _on_event_started(fish_behavior: FishResource):
	current_fish = fish_behavior
	fishing_started = true
	
	set_next_action()

func set_next_action() -> void:
	current_action_index += 1
	if current_action_index >= current_fish.fish_actions.size():
		current_action_index = 0
	current_fish_action = current_fish.fish_actions[current_action_index]
	action_time = current_fish_action.duration
	match current_fish_action.action_type:
		FishAction.ActionType.RECOVERY:
			bobber_current_state = BobberStates.RECOVERY
		FishAction.ActionType.FIGHTING:
			bobber_current_state = BobberStates.FIGHTING
		FishAction.ActionType.DASH:
			bobber_current_state = BobberStates.DASHING

func throw_bobber(cast_position: Vector2) -> void:
	print("bubbler_throwed")
	bobber_current_state = BobberStates.WAITING
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
	fishing_started = false
	bobber_current_state = BobberStates.IDLE
	var tween: Tween = create_tween()
	tween.tween_property(
		self,"global_position",bobber_default_position,0.2
	)
	await tween.finished
	
func is_in_fishing_area() -> bool:
	if bobber_area_2d.get_overlapping_areas():
		return true
	return false
