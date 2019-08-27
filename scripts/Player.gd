extends Area

onready var camera: Camera = get_viewport().get_camera()
onready var scene_controller = get_node("/root/Scene")

var input_velocity: Vector2
var velocity: Vector3


func _process(delta):
	input_velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_velocity.y = Input.get_action_strength("up") - Input.get_action_strength("down")

	velocity.x = lerp(velocity.x, input_velocity.x, TURN_SPEED * delta)
	velocity.y = lerp(velocity.y, input_velocity.y, TURN_SPEED * delta)

	rotation.x = velocity.y
	rotation.y = -velocity.x
	rotation.z = -velocity.x

	global_translate(velocity)

	# Handle boundary collisions
	transform.origin = scene_controller.handle_boundary_collision(transform.origin)

	# Update camera
	camera.transform.origin = Vector3(CAM_OFFSET_PERCENT * transform.origin.x, CAM_OFFSET_PERCENT * transform.origin.y, transform.origin.z) + CAM_OFFSET
	camera.look_at(transform.origin - transform.basis.z, Vector3.UP)


const CAM_OFFSET: Vector3 = 2 * Vector3.UP + 12 * Vector3.BACK
const CAM_OFFSET_PERCENT: float = 0.95
const TURN_SPEED: float = 2.0
