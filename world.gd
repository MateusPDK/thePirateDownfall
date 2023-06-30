extends Node3D

var interface=null
var ball_comp=preload("res://cannon_ball.tscn")
var total_counter = 0
var hit_counter = 0
var gameover = false

var timer = 0
const interval = 2.0  # Interval between function calls (in seconds)

# Called when the node enters the scene tree for the first time.
func _ready():
	interface=XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		get_viewport().use_xr=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta

	if timer >= interval:
		timer = 0
		createBall()
		
	if (total_counter - hit_counter) >= 5:
		gameOver()
		
	if gameover:
		if Input.is_action_just_pressed("escape"):
			restart()
	else:
		if Input.is_action_just_pressed("escape"):
			get_tree().paused = !get_tree().paused
	
	
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

func sinkShip():
	var bobOffset = sin(Engine.get_frames_drawn() * 0.5 * 0.01) * 0.75
	$mc_ship.transform.origin.x = bobOffset

func gameOver():
	sinkShip()
	gameover = true
	$song.stop()
	get_tree().paused = true
	get_tree().get_root().set_disable_input(false)
	$gameover.play()
	
	$UI/game_over.visible = true

func restart():
	gameover = false
	$UI/game_over.visible = false
	total_counter = 0
	hit_counter = 0
	get_tree().paused = false
	
