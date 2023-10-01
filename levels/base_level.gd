extends Node3D

@onready var player : MeshInstance3D = $Player
@onready var debug_label : Label = $Label
@onready var trans_rect : ColorRect = $TransitionColorRect

@export var next_scene : PackedScene

func _ready():
	GM.gridmap = $GridMap
	transition_to_level()
	player.connect("win", win_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	debug_label.text = ""
	debug_label.text += "FPS: " + str(Engine.get_frames_per_second())
	debug_label.text += "\nW: Move Forward"
	debug_label.text += "\nA - D: Rotate"
	debug_label.text += "\nSpaceBar: Attract Object"
	debug_label.text += "\nR: Restart Level"

func _input(event):
	if event.is_action_pressed("reload_scene"):
		get_tree().reload_current_scene()

func transition_to_level():
	var color_tween : Tween = create_tween()
	color_tween.tween_property(trans_rect, "color", Color("Black", 0.0), 1.2)

func win_level():
	player.process_mode = Node.PROCESS_MODE_DISABLED
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
