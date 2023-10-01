extends Area3D

@onready var fan : MeshInstance3D = $MeshInstance3D

func _process(delta):
	fan.rotate_y(2 * delta)
