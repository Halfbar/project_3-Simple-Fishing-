extends Resource
class_name FishResource

# fish behaviour
# fish can have states and each fish 
# mix them in their own array of moves
# recovery - stand still 
# fighting - trying to escape
# dash - dash on short distance

@export var event_chance: float
@export var fish_speed: float
@export var fish_actions: Array
