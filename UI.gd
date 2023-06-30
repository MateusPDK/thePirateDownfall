extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	var world = get_node("..")
	
	if world.gameover:
		if Input.is_action_just_pressed("escape"):
			world.total_counter = 0
			world.hit_counter = 0
			world.restart()
	else:
		if Input.is_action_just_pressed("escape"):
			if get_tree().paused:
				$paused.visible = false
				get_tree().paused = false
			else:
				$paused.visible = true
				get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
