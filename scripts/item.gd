class_name Item
extends Node2D

@export var item_id: int = 0

@onready var icon = $icon
@onready var area = $Area2D

@onready var player: Player = get_node("../../../../../player")
@onready var enemy: Player = get_node("../../../../../opponent")

var item_actions = {}

func _ready():
	icon.frame = item_id
	setup_item_actions()

func setup_item_actions():
	for i in range(13):
		item_actions[i] = Callable(self, "item_%s_action" % i)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		useItem(item_id)

func useItem(id):
	if id in item_actions:
		item_actions[id].call()

func item_0_action():
	if player:
		switch_cards(player, enemy)
	else:
		switch_cards(enemy, player)
	queue_free()

func item_1_action():
	if player:
		switch_cards(player, enemy)
	else:
		switch_cards(enemy, player)
	queue_free()


func switch_cards(from_player, to_player):
	var cards_to_switch = from_player.get_children()
	var cards_to_switch_opponent = to_player.get_children()
	
	var temp_card_pos = 0
	for card in cards_to_switch:
		temp_card_pos = 0
		var last_card_buyed
		if card is Card:
			card.get_parent().remove_child(card)
			to_player.add_child(card)
			card.card_hidden = true
			card.sprite_2d.frame = 66
			# Adjust the position of the card if necessary
			temp_card_pos = card.position
			last_card_buyed = card
			card.position = Vector2(last_card_buyed.position.x - 12, 0)
			card.z_index = to_player.get_child_count()  # Ensure cards are stacked correctly

	for card in cards_to_switch_opponent:
		var last_card_buyed
		if card is Card:
			card.get_parent().remove_child(card)
			from_player.add_child(card)
			card.card_hidden = false
			card.sprite_2d.frame = card.card_index
			# Adjust the position of the card if necessary
			temp_card_pos = card.position
			last_card_buyed = card
			card.position = Vector2(last_card_buyed.position.x + 12, 0)
			card.z_index = from_player.get_child_count()  # Ensure cards are stacked correctly
