class_name Card

extends Node2D

var card_index: int = 0
var card_value: int = 0

@onready var sprite_2d = $Sprite2D

signal cardCreated

# Called when the node enters the scene tree for the first time.
func _ready():
	card_index = randi() % 52
	
	sprite_2d.frame = card_index
	
	card_value = (card_index % 13) + 1
	var card_suit = card_index / 13

	if card_value >= 11 and card_value <=13:
		card_value = 10



	print("Card Value: ", card_value, " Card Suit: ", card_suit)
	cardCreated.emit()  # Ensure this is called after all setups
