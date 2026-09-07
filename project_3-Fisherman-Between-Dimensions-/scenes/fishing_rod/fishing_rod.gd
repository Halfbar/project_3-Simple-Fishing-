extends Node2D
class_name FishingRod

@onready var fishing_distance_collision: CollisionShape2D = $fishing_distance_area2d/fishing_distance_collision
@onready var fishing_catch_collision: CollisionShape2D = $fishing_catch_area2d/fishing_catch_collision

enum RodStates {
	IDLE,
	CHARGING,
	CASTING,
	WAITING,
	FISHING,
	CAUGHT,
	FAILED
}

@export var bobber: Bobber

var current_state: RodStates = RodStates.IDLE

var max_stamina: float = 100.0
var stamina: float = 100.0
var stamina_regeniration: float = 4.0
var reel_stamina_drain: float = 8.0

var is_reeling: bool = false

func _ready() -> void:
	SignalBus.event_started.connect(_on_event_started)
	GameManager.fishing_rod = self

func get_fishing_min_radius():
	return fishing_catch_collision.shape.radius * global_scale.x

func get_fishing_max_radius():
	return fishing_distance_collision.shape.radius * global_scale.x

func _on_event_started(_fish_behavior):
	stamina = max_stamina
	set_state(RodStates.FISHING)

func _process(delta: float) -> void:
	if is_reeling:
		return
	stamina = min(
	stamina + stamina_regeniration * delta,
	max_stamina
	)

func reel(delta: float):
	# rod is moving bobber closer to it
	# and drains stamina depends on strenght of action
	# if stamina is 0 - can`t pull bobber
	# stamina recharging by itself in a while
	if current_state != RodStates.FISHING:
		return
	if stamina <= 0:
		return
	is_reeling = true
	bobber.move_to_rod(delta)
	var drain := (
		bobber.current_fish_action.strength
		+ reel_stamina_drain
	)
	stamina -= drain * delta
	stamina = max(stamina, 0.0)
	print("Stamina: " + str(stamina))

func stop_reeling():
	is_reeling = false

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
	if !bobber.is_in_fishing_area():
		print("not_in_lake")
		await bobber.set_default_position()
		set_state(RodStates.IDLE)
		return
	set_state(RodStates.WAITING)

func set_state(new_state: RodStates):
	if current_state == new_state:
		return
	current_state = new_state
	queue_redraw()
	SignalBus.fishing_rod_state.emit(current_state)

func _on_fishing_catch_area_2d_area_entered(area: Area2D) -> void:
	if current_state == RodStates.FISHING:
		print("Caught")
		set_state(RodStates.CAUGHT)
		set_state(RodStates.IDLE)
		return

func _on_fishing_distance_area_2d_area_exited(area: Area2D) -> void:
	if current_state == RodStates.FISHING:
		print("Failed")
		set_state(RodStates.FAILED)
		set_state(RodStates.IDLE)
		return

func _draw() -> void:
	if current_state != RodStates.FISHING:
		return
	var circle = fishing_catch_collision.shape
	var circle2 = fishing_distance_collision.shape
	
	draw_arc(
		Vector2.ZERO,
		circle2.radius,
		0.0,
		TAU,
		64,
		Color.BLACK,
		2.0
	)
	draw_arc(
		Vector2.ZERO,
		circle.radius,
		0.0,
		TAU,
		64,
		Color.RED,
		2.0
	)
