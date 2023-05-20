extends XRController3D

# Adjust these variables to control the hit animation
var hitAnimationDuration = 0.2
var hitRotationAngle = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("atack"):
		start_hit_animation()

func start_hit_animation():
	var originalRotation = rotation
	var targetRotation = originalRotation.rotated(Vector3(0, 1, 0), deg_to_rad(hitRotationAngle))

	# Use a Tween node or a Timer to animate the rotation over time
	var tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(self, "rotation", originalRotation, targetRotation, hitAnimationDuration,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	tween.connect("tween_completed", self, "_on_tween_completed")

func _on_tween_completed(object: Object, key: NodePath, value: Variant):
	reset_sword_rotation()

func reset_sword_rotation():
	rotation = Vector3(0, 0, 0)  # Reset the sword rotation to its original position

func _process(delta):
	pass
