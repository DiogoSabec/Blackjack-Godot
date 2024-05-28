extends Node2D

@export var item_id: int = 0

@onready var icon = $icon

# Called when the node enters the scene tree for the first time.
func _ready():
	icon.frame = item_id


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
