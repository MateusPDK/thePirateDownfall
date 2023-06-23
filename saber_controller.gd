extends XRController3D

# Adjust these variables to control the hit animation
var hitAnimationDuration = 0.2
var hitRotationAngle = 15
var lastPos = Vector3(0,0,0)
var dir = Vector3(0,0,0)
var sword_hit = null

# Called when the node enters the scene tree for the first time.
func _ready():
	lastPos = $saber/Marker3D.global_position
	self.rotation_degrees = Vector3(35,0,0)

func _process(delta):
	if (get_viewport().use_xr == true):
		dir = ($saber/Marker3D.global_position - lastPos).normalized()
		lastPos = $saber/Marker3D.global_position
	else:
		dir = ($saber/Marker3D.global_position - lastPos).normalized()
		lastPos = $saber/Marker3D.global_position
		# p:  x 0, y 0, z -1.852
		# r: x -83.2, y 0, z 0
		self.position = Vector3(0,0,-1.85)
		
		if (sword_hit != null):
			if (!sword_hit.is_valid()):
				self.rotation_degrees = Vector3(35,0,0)
		else:
			self.rotation_degrees = Vector3(35,0,0)

		if Input.is_action_just_pressed("atack"):
			sword_hit = get_tree().create_tween()
			sword_hit.tween_property(self, "rotation_degrees", Vector3(-90,0,0), 0.2)
			sword_hit.tween_property(self, "rotation_degrees", Vector3(35,0,0), 0.2)
	
