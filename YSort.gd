extends YSort

func _ready():
	for node in self.get_children():
		node.z_index = node.position.y
