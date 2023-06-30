extends Node3D

var interface=null
var ball_comp=preload("res://cannon_ball.tscn")
var total_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	interface=XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		get_viewport().use_xr=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func createBall():
	var cannon1 = Vector3(-153, 6, 16.5)
	var cannon2 = Vector3(-153, 6, -0.8)
	var cannon3 = Vector3(-153, 6, -18)

	var ball = ball_comp.instantiate()
	
	var cannonPositions = [cannon1, cannon2, cannon3]
	var randomIndex = randi() % cannonPositions.size()
	var selectedPosition = cannonPositions[randomIndex]
	
	ball.position = selectedPosition
	self.add_child(ball)
