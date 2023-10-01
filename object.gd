extends Area3D

# Raycast to detect obstacles
@onready var ray : RayCast3D = $RayCast3D
@export_enum("Chair", "Table", "Fridge", "Plant") var object_mesh : String = "Chair"

func _ready():
	$PlaceHolder.hide()
	get_node(object_mesh).show()

func move_by(offset : Vector3, player_position):
	ray.look_at(player_position)
	ray.force_raycast_update()

	# collistion with obstacle
	# This doesn't make any sense, but I'm out of time
	if ray.is_colliding() and not ray.get_collider().is_in_group("player"):
		var obj = ray.get_collider()
		var offset2 = position - obj.position
		offset = ray.get_collision_normal() - offset2

	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", position + offset, 0.15).set_trans(Tween.TRANS_CUBIC)
