extends Node3D

var interface=null
var ball_comp=preload("res://test_ball_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	interface=XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		get_viewport().use_xr=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func createBall():
	var ball = ball_comp.instantiate()
	ball.position = Vector3(.05,10,-1)
	self.add_child(ball)
