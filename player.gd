extends Node3D

var moving : bool = false
var rotating : bool = false
# Raycast to check if player can move
@onready var move_raycast : RayCast3D = $MoveRayCast3D
# Raycast to get the object in front of the player
@onready var obj_raycast : RayCast3D = $ObjectRayCast3D
# Raycast to detect win area
@onready var win_raycast : RayCast3D = $WinRayCast3D

func _physics_process(_delta):
	if Input.is_action_pressed("move_forward"):
		move(Vector3.FORWARD)
	if Input.is_action_just_pressed("turn_around"):
		turn(PI)
	if Input.is_action_just_pressed("turn_left"):
		turn(PI/2)
	if Input.is_action_just_pressed("turn_right"):
		turn(-PI/2)

	# Attract Objects
	if Input.is_action_just_pressed("pull_object"):
		#print(obj_raycast.get_collision_normal())
		if obj_raycast.is_colliding():
			var obj = obj_raycast.get_collider()
			if obj.is_in_group("movable"):
				var offset = position - obj.position
				#obj.position += offset - obj_raycast.get_collision_normal()
				obj.move_by(offset - obj_raycast.get_collision_normal(), position)

func move(dir: Vector3):
	if not moving and not rotating and not move_raycast.is_colliding():
		moving = true
		var move_tween : Tween = create_tween()
		move_tween.tween_property(self, "position", dir.rotated(Vector3.UP, rotation.y), 0.2).as_relative().set_trans(Tween.TRANS_CUBIC)
		await move_tween.finished
		moving = false

	if win_raycast.is_colliding() and win_raycast.get_collider().is_in_group("win_area"):
		print("win")

func turn(angle : float):
	if not moving and not rotating:
		rotating = true
		var rot_tween : Tween = create_tween()
		rot_tween.tween_property(self, "rotation:y", rotation.y + angle, 0.1).set_trans(Tween.TRANS_CUBIC)
		await rot_tween.finished
		rotating = false
