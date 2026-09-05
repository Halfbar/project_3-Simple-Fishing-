extends Resource
class_name FishAction

enum ActionType {
	RECOVERY,
	FIGHTING,
	DASH
}

@export var action_type: ActionType
@export var duration: float = 1.0
@export var strength: float = 1.0
