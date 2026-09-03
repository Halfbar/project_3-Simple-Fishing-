extends Node

@export var fish_array: Array[FishResource]

var current_fishing_area: FishingArea
var all_fishes: Array[FishResource]

func _ready() -> void:
	SignalBus.fishing_rod_state.connect(_on_fishing_rod_state)

func _on_fishing_rod_state(rod_current_state: FishingRod.RodStates) -> void:
	print("Rod state: ", rod_current_state)
	if rod_current_state == FishingRod.RodStates.WAITING:
		try_start_event()

# wait until timer run out
# flip coin
# if coin failed start timer again
# else trigger event and send signal
# signal contains fish behaivor selected randomly from all_fishes
# after that bobber take that signal and start moving
# rod change state to start game
# ui will show up

func try_start_event():
	print("Try start event!")
	var timer: float = 5.0
	var chance: float = 0.3
	await get_tree().create_timer(timer).timeout
	if randf() <= chance:
		trigger_event()
	else:
		try_start_event()

func trigger_event():
	#var fish_behavior = all_fishes.pick_random()
	#SignalBus.event_started.emit(fish_behavior)
	print("Event started!")
