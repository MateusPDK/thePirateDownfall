extends Node3D

var bola_comp = preload("res://cannon_ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player=get_node("character")
	if Input.is_action_just_pressed("ui_accept"):
		var bola = bola_comp.instantiate()
		bola.direction = Vector3(1, 0, 1)
		bola.force = 20
		bola.position = Vector3(6.376, 1.579, 0.073)
		self.add_child(bola)
	pass
