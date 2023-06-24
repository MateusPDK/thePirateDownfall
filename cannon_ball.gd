extends RigidBody3D

var direction = Vector3(0, 1 ,1)
var force = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	disparar(self.direction, self.force)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func disparar(direction, force):
	direction = direction.normalized()
	self.apply_central_impulse(direction * force)
