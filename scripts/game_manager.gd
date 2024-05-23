class_name SceneManager
extends Node

@export var player_cards: Array = []
@export var total_points: int = 0

@onready var pontuacao = $Pontuacao  # Ensure this path is correct
@onready var comprar = $comprar
@onready var carta = preload("res://scenes/carta.tscn")  # Path to your Card scene


func _on_comprar_pressed():
	var new_card = carta.instantiate()
	add_child(new_card)
	player_cards.append(new_card)
	total_points += new_card.card_value

	pontuacao.text = 'Total Points: ' + str(total_points)
	
func _process(delta):
	if total_points > 21:
		pontuacao.text = 'You lost! \nYou have ' + str(total_points) + ' points!'
