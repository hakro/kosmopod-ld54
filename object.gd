extends Area3D

func move_by(offset : Vector3):
	var move_tween : Tween = create_tween()
	move_tween.tween_property(self, "position", position + offset, 0.15).set_trans(Tween.TRANS_CUBIC)
