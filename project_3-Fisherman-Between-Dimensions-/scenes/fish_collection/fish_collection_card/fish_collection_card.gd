extends Control

@onready var card_up_part_label: Label = $card_panel/card_vbox/card_up_part/card_up_part_margin/card_up_part_vbox/card_up_part_label
@onready var card_up_part_texture: TextureRect = $card_panel/card_vbox/card_up_part/card_up_part_margin/card_up_part_vbox/card_up_part_texture
@onready var card_down_part_label: Label = $card_panel/card_vbox/card_down_part/card_down_part_margin/card_down_part_label


func setup(fish: FishResource):
	card_up_part_label.text = fish.fish_name
	if fish.fish_caught:
		card_up_part_texture.texture = fish.fish_texture
		card_up_part_texture.self_modulate = Color.WHITE
		card_down_part_label.text = fish.fish_description
	else:
		card_up_part_texture.texture = fish.fish_texture
		card_up_part_texture.self_modulate = Color.BLACK
		card_down_part_label.text = "???"
