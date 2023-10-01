extends Area3D

# Raycast to detect obstacles
@onready var ray : RayCast3D = $RayCast3D

func move_by(offset : Vector3, player_position):
	ray.look_at(player_position)
	ray.force_raycast_update()

	# collistion with obstacle
	if ray.is_colliding():
		var obj = ray.get_collider()
		var offset2 = position - obj.position
		offset = ray.get_collision_normal() - offset2

	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", position + offset, 0.15).set_trans(Tween.TRANS_CUBIC)
