extends Node3D

var moving : bool = false
# Raycast to check if player can move
@onready var move_raycast : RayCast3D = $MoveRayCast3D
# Raycast to get the object in front of the player
@onready var obj_raycast : RayCast3D = $ObjectRayCast3D

func _physics_process(_delta):
	if Input.is_action_pressed("move_forward"):
		move(Vector3.FORWARD)
	if Input.is_action_pressed("move_backward"):
		move(Vector3.BACK)
	if Input.is_action_pressed("move_left"):
		move(Vector3.LEFT)
	if Input.is_action_pressed("move_right"):
		move(Vector3.RIGHT)
	
	# Attract Objects
	if Input.is_action_just_pressed("pull_object"):
		#print(obj_raycast.get_collision_normal())
		if obj_raycast.is_colliding():
			var obj = obj_raycast.get_collider()
			var offset = position - obj.position
			#obj.position += offset - obj_raycast.get_collision_normal()
			obj.move_by(offset - obj_raycast.get_collision_normal())
		

func move(dir: Vector3):
	var rot_tween : Tween = create_tween()
	rot_tween.tween_property(self, "rotation:y", Vector3.FORWARD.signed_angle_to(dir, Vector3.UP), 0.05)
	await rot_tween.finished
	move_raycast.force_raycast_update()
	if not moving and not move_raycast.is_colliding():
		moving = true
		var move_tween : Tween = create_tween()
		move_tween.tween_property(self, "position", dir, 0.15).as_relative().set_trans(Tween.TRANS_CUBIC)
		await move_tween.finished
		moving = false
