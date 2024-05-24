class_name Player

extends Node2D

@onready var card = preload("res://scenes/carta.tscn")
@onready var game_manager = %GameManager
@onready var pontuacao = $"../GameManager/Pontuacao"

@export var total_points: int = 0
var item_list: Array = []
var has_skipped: bool

@export var opponent: bool
@export var current_turn: bool
@export var enemy: Player

var last_card_buyed: Card

func _ready():
	buyCard()
	buyCard()

func buyCard():
	var new_card = card.instantiate()
	add_child(new_card)
	game_manager.cards_bought.append(new_card.card_index)
	total_points += new_card.card_value
	
	if last_card_buyed != null:
		if opponent:
			new_card.position.x = last_card_buyed.position.x - 15
		else:
			new_card.position.x = last_card_buyed.position.x + 15
	
	if opponent:
		new_card.card_hidden = 1
	else:
		pontuacao.text = 'Total Points: ' + str(total_points)

	if new_card.card_hidden:
		new_card.sprite_2d.frame = 66
	else:
		new_card.sprite_2d.frame = new_card.card_index
	
	
	
	last_card_buyed = new_card
	current_turn = false
	enemy.current_turn = true

func skipTurn():
	current_turn = false
	enemy.current_turn = true

func useItem():
	pass
