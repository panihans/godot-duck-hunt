extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var score = 0

var off_x = 75
var off_y = 150

var r = RandomNumberGenerator.new()

var game_time = 60

func _ready():
	get_node("/root/World/UI/GameOverScreen").hide()

func _process(delta):
	get_node("/root/World/UI/TimerValueLabel").text = str(game_time)
	get_node("/root/World/UI/ScoreValueLabel").text = str(score)
	
	if game_time <= 0:
		get_node("/root/World/UI/GameOverScreen").show()
		if Input.is_action_just_pressed("Reload"):
			get_tree().reload_current_scene()
		return
		

	var m = get_global_mouse_position()
	position.x = lerp(position.x, m.x + off_x, 0.25)
	position.y = lerp(position.y, m.y + off_y, 0.25)

func _on_GameTimer_timeout():
	game_time -= 1
	game_time = max(game_time, 0)
