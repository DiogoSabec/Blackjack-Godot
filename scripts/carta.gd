class_name Card

extends Node2D

@export var card_index: int = 0
@export var card_value: int = 0

@onready var game_manager = get_node("../../GameManager")
@onready var sprite_2d: Sprite2D = $Sprite2D

var card_hidden: bool = false

func _ready():
	if not game_manager:
		print("GameManager is not initialized")
		return  # Exit if game_manager is not found

	card_index = randi() % 66
	# Check if card_index is in the game_manager's cards_bought; if yes, select another index
	while card_index in game_manager.cards_bought:
		card_index = randi() % 66

	sprite_2d.frame = card_index
	card_value = (card_index % 13) + 1
	var card_suit = int(card_index / 13) 

	# Images (Jack, Queen, King) are worth 10
	if card_value >= 11 and card_value <= 13:
		card_value = 10 

	print("Card Value: ", card_value, " Card Suit: ", card_suit)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("lol it works")
