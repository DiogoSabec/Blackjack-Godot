class_name Card

extends Node2D

@export var card_index: int = 0
@export var card_value: int = 0

@onready var game_manager = get_node("../../GameManager")
@onready var sprite_2d: Sprite2D = $Sprite2D

var card_hidden: bool = false

const MAX_CARD_INDEX = 65
const CARD_SUIT_DIVISOR = 13
const FACE_CARD_VALUE = 10

func _ready():
	if not game_manager:
		print("GameManager is not initialized")
		return  # Exit if game_manager is not found

	select_card_index()
	set_card_properties()

func select_card_index():
	card_index = randi() % (MAX_CARD_INDEX + 1)
	while card_index in game_manager.cards_bought:
		card_index = randi() % (MAX_CARD_INDEX + 1)

func set_card_properties():
	sprite_2d.frame = card_index
	card_value = (card_index % CARD_SUIT_DIVISOR) + 1

	if card_value >= 11:
		card_value = FACE_CARD_VALUE 

	var card_suit = int(card_index / CARD_SUIT_DIVISOR) 
	print("Card Value: ", card_value, " Card Suit: ", card_suit)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("lol it works")

