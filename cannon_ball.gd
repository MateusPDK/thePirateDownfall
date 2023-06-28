extends RigidBody3D

var timer = 10
var direction = Vector3(0, 1 ,1)
var force = 10
var pos_old = Vector3(0,0,0)
var dir = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	disparar(self.direction, self.force)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer <= 0:
		queue_free()
		
	dir = (self.position - pos_old).normalized()
	pos_old = self.position

func disparar(direction, force):
	direction = direction.normalized()
	self.apply_central_impulse(direction * force)

func bat(vdir):
	if get_viewport().use_xr == false:
		dir = Vector3(0,0,-1) * 10
		vdir = dir

	self.apply_central_impulse(vdir.normalized() * 5000)
