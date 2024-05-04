extends Area2D

@onready var game_manager: GameManager = %GameManager
@onready var pickup_sound: AudioStreamPlayer = $PickupSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(_body):
	animation_player.play("pickup_animation")
	game_manager.add_coin()
