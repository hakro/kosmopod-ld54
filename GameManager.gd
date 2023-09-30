extends Node

var gridmap : GridMap

func get_grid_location(pos : Vector3) -> Vector3i:
	return gridmap.local_to_map(pos)

func get_world_location(pos : Vector3i) -> Vector3:
	return gridmap.map_to_local(pos)
