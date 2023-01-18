extends Node2D



var duckprefab = preload("res://Duck.tscn")

var spawns = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for n in $YSort.get_children():
		if "bush" in n.name.to_lower():
			spawns.append(n)

func _on_Timer_timeout():
	var running = get_node("/root/World/Player").game_time > 0
	if not running:
		return
		
	print("timeout")
	var d = duckprefab.instance()
	
	var sp = spawns[randi() % spawns.size()]
	
	d.position = Vector2(sp.position.x+50, sp.position.y-25)
	d.z_index = sp.z_index - 1
	add_child(d)
