class_name Player
extends Node2D

@onready var card_scene = preload("res://scenes/carta.tscn")
@onready var item = preload("res://scenes/item.tscn")
@onready var game_manager = $"../GameManager"
@onready var pontuacao = $"../GameManager/Pontuacao"

@export var total_points: int = 0
var item_list: Array = []
var has_skipped: bool = false

@export var opponent: bool = false
@export var current_turn: bool = false
@export var enemy: Player
@export var inventory: GridContainer

var last_card_buyed: Card

# Compra 2 cartas ao iniciar
func _ready():
	buyCard()
	buyCard()

func buyCard():
	var new_card = card_scene.instantiate()
	add_child(new_card)
	game_manager.cards_bought.append(new_card.card_index)
	
	
	if new_card.card_index >= 52:
		addItem(new_card, new_card.card_index)
	else:
		total_points += new_card.card_value
		if last_card_buyed != null:
			if opponent:
				new_card.position = Vector2(last_card_buyed.position.x - 15, 0)
				new_card.z_index = last_card_buyed.z_index + 1
			else:
				new_card.position = Vector2(last_card_buyed.position.x + 15, 0)
				new_card.z_index = last_card_buyed.z_index + 1
		last_card_buyed = new_card

	if opponent:
		new_card.card_hidden = 1
	else:
		pontuacao.text = 'Total Points: ' + str(total_points)

	if new_card.card_hidden:
		new_card.sprite_2d.frame = 66
	else:
		new_card.sprite_2d.frame = new_card.card_index

	switch_turns()

func skipTurn():
	switch_turns()

func switch_turns():
	current_turn = false
	enemy.current_turn = true
	enemy.has_skipped = false

func addItem(card, index):
	var new_item = item.instantiate()
	item_list.append(new_item)
	new_item.item_id = (index - 52) % 13
	
	for texture_rect in inventory.get_children():
		if texture_rect.get_child_count() == 0:
			texture_rect.add_child(new_item)
			new_item.position = Vector2(8, 8)
			break
	
	card.queue_free()
