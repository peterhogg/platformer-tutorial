class_name GameManager extends Node

var total_coins: int = 0
var coins_collected: int = 0

var label_format_string = "You got %s / %s  coins"

@onready var coins: Node = %Coins
@onready var score_label: Label = $ScoreLabel


func _ready():
	total_coins = coins.get_child_count();

func add_coin():
	coins_collected += 1
	score_label.text = label_format_string % [coins_collected, total_coins]
	
