extends Node2D

@export var item_id: int = 0

@onready var icon = $icon
@onready var area = $Area2D  # Ensure this path correctly references your Area2D node

var item_actions = {}

func _ready():
	icon.frame = item_id
	setup_item_actions()

func setup_item_actions():
	for i in range(13):  # This covers item IDs from 0 to 12
		item_actions[i] = Callable(self, "item_%s_action" % i)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		useItem(item_id)

func useItem(id):
	if id in item_actions:
		item_actions[id].call()

func item_0_action():
	print("Action for item 0")

func item_1_action():
	print("Action for item 1")

func item_2_action():
	print("Action for item 2")

func item_3_action():
	print("Action for item 3")

func item_4_action():
	print("Action for item 4")

func item_5_action():
	print("Action for item 5")

func item_6_action():
	print("Action for item 6")

func item_7_action():
	print("Action for item 7")

func item_8_action():
	print("Action for item 8")

func item_9_action():
	print("Action for item 9")

func item_10_action():
	print("Action for item 10")

func item_11_action():
	print("Action for item 11")

func item_12_action():
	print("Action for item 12")
