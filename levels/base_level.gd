extends Node3D

@onready var debug_label : Label = $DebugLabel

func _ready():
	GM.gridmap = $GridMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	debug_label.text = "FPS: " + str(Engine.get_frames_per_second())
	debug_label.text += "\nPlayer Grid coord:" + str($GridMap.local_to_map(($Player.position)))
	#debug_label.text += "\nPlayer Rot:" + str($Player.rotation.y)
	#debug_label.text += "\nForward:" + str(Vector3.FORWARD)
	#debug_label.text += "\nRotated:" + str(Vector3.FORWARD.rotated(Vector3.UP, PI))

#func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#var block_in_grid = $GridMap.local_to_map($Object1.position)
		##print(block_in_grid)
		#block_in_grid.z -= 1
		#$Object1.position = $GridMap.map_to_local(block_in_grid)
