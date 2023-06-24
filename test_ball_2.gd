extends RigidBody3D

var timer = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer <= 0:
		queue_free()

func bat(dir):
	# self.apply_central_impulse((self.position - saber.global_position).normalized() * 50)
	# var v = self.position - dir.global_position.normalized()
	# v = Vector3(v.x, 0, v.z).normalized()
	# v.y = randf_range(0,2)
	self.apply_central_impulse(dir.normalized() * 50)
