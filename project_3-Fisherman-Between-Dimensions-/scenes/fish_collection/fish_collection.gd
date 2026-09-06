extends Control

@onready var fish_collection_card: Control = $collection_panel/VBoxContainer/collection_hbox/card_margin/fish_collection_card

var current_index: int = 0
var current_shown_fish: FishResource

func _ready() -> void:
	set_new_fish(0)

func _on_prev_btn_pressed() -> void:
	if GameManager.all_fishes.is_empty():
		return
	current_index -= 1
	if current_index < 0:
		current_index = GameManager.all_fishes.size() - 1
	set_new_fish(current_index)

func _on_next_btn_pressed() -> void:
	if GameManager.all_fishes.is_empty():
		return
	current_index += 1
	if current_index >= GameManager.all_fishes.size():
		current_index = 0
	set_new_fish(current_index)

func set_new_fish(index: int) -> void:
	if GameManager.all_fishes.is_empty():
		return
	current_index = index
	current_shown_fish = GameManager.all_fishes[current_index]
	fish_collection_card.setup(current_shown_fish)
