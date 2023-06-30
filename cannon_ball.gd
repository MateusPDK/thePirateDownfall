extends RigidBody3D

var timer = 10
var pos_old = Vector3(0,0,0)
var dir = Vector3(0,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	disparar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer <= 0:
		queue_free()
		
	dir = (self.position - pos_old).normalized()
	pos_old = self.position

func disparar():
	# SFX
	$cannon_fired.play()
	
	# Update UI
	var world = get_node("..")
	world.total_counter = world.total_counter + 1
	var shooted_label = get_node("../UI/shooted")
	shooted_label.text = "Total: " + str(world.total_counter)

	var character = get_node("../character")
	var ball_dir = character.global_position - self.global_position
	
	# Adjust the speed and arc parameters to achieve the desired effect
	var speed = 100  # Adjust the speed as needed
	var arc = 10  # Adjust the arc as needed
	
	# Calculate the initial velocity with the desired speed and arc
	var initial_velocity = ball_dir.normalized() * speed
	initial_velocity.y += arc
	
	# Apply the initial velocity to the cannonball
	self.linear_velocity = initial_velocity
	
	# Apply gravity to simulate an arc trajectory
	var gravity = Vector3(0, -9.8, 0)  # Adjust the gravity as needed
	self.gravity_scale = 1  # Enable gravity on the cannonball
	#  self.gravity_vector = gravity

func bat(vdir):
	if get_viewport().use_xr == false:
		dir = Vector3(0,0,-1) * 10
		vdir = dir

	self.apply_central_impulse(vdir.normalized() * 1000000)
