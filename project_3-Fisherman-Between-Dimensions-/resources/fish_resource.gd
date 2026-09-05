extends Resource
class_name FishResource

# fish behaviour
# fish can have states and each fish 
# mix them in their own array of moves
# recovery - stand still 
# fighting - trying to escape
# dash - dash on short distance

@export_category("Fish")
@export var fish_name: String
@export var fish_speed: float = 100.0
@export_category("Behaviour")
@export var fish_actions: Array[FishAction]
@export_category("Event")
@export_range(0.0, 1.0)
var event_chance: float = 0.3
