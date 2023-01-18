extends Node2D

var max_shots = 5
var shots = max_shots

var reloading = false
var reload_speed = 0.5
var bullets = []

func _ready():
	bullets = [$Bullet, $Bullet2, $Bullet3, $Bullet4, $Bullet5]

func _process(delta):
	var running = get_node("/root/World/Player").game_time > 0
	if not running:
		return
	
	var can_reload = shots < max_shots and not reloading
	if Input.is_action_just_pressed("Reload") and can_reload:
		reloading = true
		$ReloadSound.play()
		
	if reloading:
		var idx = max_shots - (shots + 1)
		bullets[idx].value += 100 / reload_speed * delta
		if bullets[idx].value >= 100:
			shots += 1
			reloading = false
	
	var can_shoot = shots > 0 and not reloading
	if Input.is_action_just_pressed("Fire") and can_shoot:
		$FireSound.play()
		bullets[max_shots - shots].value = 0
		shots -= 1
		
		var m = get_parent().position#  get_global_mouse_position()
		m.x -= get_parent().off_x
		m.y -= get_parent().off_y
		var nodes = get_world_2d().direct_space_state.intersect_point(m, 32, [], 0x7FFFFFFF, true, true)
		if nodes.size() > 0:
			var top = nodes[0]
			for n in nodes:
				if n.collider.z_index > top.collider.z_index:
					top = n
			if "duck" in top.collider.name.to_lower():
				top.collider.kill()
			print(top.collider.name)
	if Input.is_action_just_pressed("Fire") and shots <= 0:
		$EmptySound.play()
