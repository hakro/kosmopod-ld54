extends Control

@onready var level1 : PackedScene = preload("res://levels/level_1.tscn")

func _on_timer_timeout():
	$Label.visible = !$Label.visible

func _input(event):
	if event.is_action_pressed("pull_object"):
		$SpacePressed.play()
		await $SpacePressed.finished
		get_tree().change_scene_to_packed(level1)
