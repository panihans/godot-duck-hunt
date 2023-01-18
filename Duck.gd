extends KinematicBody2D


var motion = Vector2(0, 0)
var dir = [-25, -15, -10, -5, 0, 5, 10, 15, 25]
var d = 0
var min_speed = -200
var max_speed = 200
var daccel = -10
var a = 0
var alive = true

func _ready():
	_on_Timer_timeout()
	var score = get_node("/root/World/Player").score
	if score == 0:
		$Timer.start(1)
	elif score > 9:
		$Timer.start(0.3)
	elif score > 5:
		$Timer.start(0.5)
	elif score > 2:
		$Timer.start(0.7)

func _physics_process(delta):
	var running = get_node("/root/World/Player").game_time > 0
	if not running:
		return
		
	print(motion)
	motion.y = max(min_speed, motion.y - a)
	motion.x = max(min_speed, motion.x - d)
	motion.x = min(max_speed, motion.x)
	move_and_slide(motion)

func _process(delta):
	var running = get_node("/root/World/Player").game_time > 0
	if not running:
		return
		
	if position.y < -100 or position.y > 1000:	
		get_parent().remove_child(self)
		print("removing")
	if not alive:
		modulate.a -= 0.005

func _on_Timer_timeout():
	d = dir[randi() % dir.size()]
	var score = get_node("/root/World/Player").score
	if alive:
		a = max(min(score*2, 10), 1)
	else:
		a = daccel

func kill():
	if alive:
		alive = false
		a = daccel
		yield(get_tree().create_timer(0.1), "timeout")
		$HitSound.play()
		get_node("/root/World/Player").score += 1

