extends Node3D

var swayAmplitude: float = 2  # Adjust the amplitude of the sway motion
var swaySpeed: float = 0.4  # Adjust the speed of the sway motion
var bobAmplitude: float = 0.75  # Adjust the amplitude of the bobbing motion
var bobSpeed: float = 0.5  # Adjust the speed of the bobbing motion

func _ready():
	pass

func _process(delta: float):
	var swayOffset = sin(Engine.get_frames_drawn() * swaySpeed * 0.01) * swayAmplitude
	self.rotation_degrees = Vector3(swayOffset, 0, 0)

	var bobOffset = sin(Engine.get_frames_drawn() * bobSpeed * 0.01) * bobAmplitude
	self.transform.origin.y = bobOffset
	self.transform.origin.z = bobOffset * 0.1
