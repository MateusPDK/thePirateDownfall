extends CharacterBody3D
var vr=false
const SPEED = 5.0
var rotate_speed=0.005
var cannon_count = 0
var direction = Vector3(0,0,0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(delta):
	if Input.is_action_just_pressed("spawn"):
		get_node("..").createBall()
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# se não estiver no chão, adiciona gravidade
	if not is_on_floor():
		velocity.y -= gravity * delta

	if get_viewport().use_xr == false:
		# Calculate movement
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		direction = (self.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Change speed
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _unhandled_input(event):
	pass
	if vr == false:
		if event is InputEventMouseMotion:
			# $XROrigin3D/XRCamera3D.rotate(Vector3.DOWN, event.relative.x * rotate_speed)
			self.rotate(Vector3.DOWN, event.relative.x * rotate_speed)
			self.rotate(self.transform.basis * Vector3.RIGHT, -event.relative.y * rotate_speed)

			$XROrigin3D/saber_controller.position= self.transform.basis * Vector3(0.5,-0.3,-1) 
			$XROrigin3D/saber_controller.rotation= self.rotation

func _on_hitbox_body_entered(body):
	if (body.is_in_group("canonball")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_node("../UI/gameover").visible=true
		get_tree().paused=true

func _on_hitbox_area_entered(area):
	if (area.is_in_group("abyss")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_node("../UI/gameover").visible=true
		get_tree().paused=true

func _on_saber_controller_button_pressed(name):
	if name == 'trigger_click':
		get_node("..").createBall()

func _on_saber_area_body_entered(body):
	if body.is_in_group("cannonball"):
		$XROrigin3D/saber_controller/slice.play()
		body.bat($XROrigin3D/saber_controller.dir)
		var world = get_node("..")
		world.hit_counter = world.hit_counter + 1
		var hits_label = get_node("../UI/hits")
		hits_label.text = "Hits: " + str(world.hit_counter)

func _on_saber_controller_input_vector_2_changed(name, value):
	direction = Vector3(value.x, 0, -value.y)
	direction = ($XROrigin3D/XRCamera3D.transform.basis * direction).normalized()
