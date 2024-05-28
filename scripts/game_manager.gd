class_name GameManager
extends Node

@export var cards_bought: Array = []

@onready var pontuacao: Label = $Pontuacao
@onready var text = $text
@onready var player = $"../player"
@onready var opponent = $"../opponent"
@export var bot_threshold: int = 17  # The score threshold for the bot to skip

var player_skipped = false
var opponent_skipped = false

func _process(delta):
	if player.total_points > 21:
		pontuacao.text = 'You lost! \nYou have ' + str(player.total_points) + ' points!'
		get_tree().paused = true
	elif opponent.total_points > 21:
		pontuacao.text = 'You win! \nOpponent has ' + str(opponent.total_points) + ' points!'
		get_tree().paused = true
	elif cards_bought.size() == 65:
		pontuacao.text = 'All cards drawn!'
		determine_winner()
	
	if player.current_turn:
		text.text = 'Your Turn!'
	else:
		text.text = 'Opponent\'s Turn!'
		if not opponent.has_skipped:
			opponent_act()

	if player_skipped and opponent_skipped:
		determine_winner()

func _on_comprar_pressed():
	if player.current_turn:
		player.buyCard()
		player_skipped = false

func _on_parar_pressed():
	if player.current_turn:
		player.skipTurn()
		player_skipped = true

func opponent_act():
	opponent.bot_act(bot_threshold)

func determine_winner():
	get_tree().paused = true
	
	var player_diff = abs(21 - player.total_points)
	var opponent_diff = abs(21 - opponent.total_points)
	
	if player_diff == opponent_diff:
		pontuacao.text = 'It\'s a tie!'
	elif player_diff < opponent_diff and player.total_points <= 21:
		pontuacao.text = 'You win! \nYou have ' + str(player.total_points) + ' points!'
	else:
		pontuacao.text = 'You lost! \nOpponent has ' + str(opponent.total_points) + ' points!'
