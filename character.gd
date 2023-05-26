extends CharacterBody3D
var vr=false
const SPEED = 5.0
var rotate_speed=0.005

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# se não estiver no chão, adiciona gravidade
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Calculate movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = ($XROrigin3D/XRCamera3D.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
			$XROrigin3D/XRCamera3D.rotate(Vector3.DOWN, event.relative.x * rotate_speed)
			$XROrigin3D/XRCamera3D.rotate($XROrigin3D/XRCamera3D.transform.basis * Vector3.RIGHT, -event.relative.y * rotate_speed)
			#rotate(Vector3.DOWN, event.relative.x * rotate_speed)
			#rotate(transform.basis * Vector3.RIGHT, -event.relative.y * rotate_speed)
			$XROrigin3D/saber_controller.position= $XROrigin3D/XRCamera3D.transform.basis * Vector3(0.5,-0.3,-1) 
			$XROrigin3D/saber_controller.rotation= $XROrigin3D/XRCamera3D.rotation

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
