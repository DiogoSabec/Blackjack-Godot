class_name GameManager

extends Node

@export var cards_bought: Array = []

@onready var pontuacao:Label = $Pontuacao  # Ensure this path is correct
@onready var text = $text

@onready var player = $"../player"
@onready var opponent = $"../opponent"
	
func _process(delta):
	
	if player.total_points > 21:
		pontuacao.text = 'You lost! \nYou have ' + str(player.total_points) + ' points!'

	if opponent.total_points > 21:
		pontuacao.text = 'You win! \nOpponent has ' + str(opponent.total_points) + ' points!'

	if cards_bought.size() == 52:
		pontuacao.text = 'All cards drawn!'
	
	if player.current_turn:
		text.text = 'Your Turn!'
	else:
		text.text = 'Opponents Turn!'


func _on_comprar_pressed():
	if player.current_turn:
		player.buyCard()
	else:
		opponent.buyCard()


func _on_parar_pressed():
	if player.current_turn:
		player.skipTurn()
	else:
		opponent.skipTurn()
