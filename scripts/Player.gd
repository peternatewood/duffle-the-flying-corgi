extends Area

onready var camera: Camera = get_viewport().get_camera()
onready var scene_controller = get_node("/root/Scene")

var input_velocity: Vector3
var velocity: Vector3 = Vector3(0, 0, -BASE_SPEED)


func _process(delta):
	input_velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_velocity.y = Input.get_action_strength("up") - Input.get_action_strength("down")

	velocity.x = lerp(velocity.x, MOVEMENT_SPEED * input_velocity.x, TURN_SPEED * delta)
	velocity.y = lerp(velocity.y, MOVEMENT_SPEED * input_velocity.y, TURN_SPEED * delta)

	rotation.x = TURN_MOD * velocity.y
	rotation.y = TURN_MOD * -velocity.x
	rotation.z = TURN_MOD * -velocity.x

	if Input.is_action_pressed("accelerate"):
		velocity.z = lerp(velocity.z, -MAX_SPEED, ACCELERATION * delta)
	elif Input.is_action_pressed("brake"):
		velocity.z = lerp(velocity.z, -MIN_SPEED, ACCELERATION * delta)
	else:
		velocity.z = lerp(velocity.z, -BASE_SPEED, ACCELERATION * delta)

	global_translate(delta * velocity)

	# Handle boundary collisions
	transform.origin = scene_controller.handle_boundary_collision(transform.origin)

	# Update camera
	camera.transform.origin = Vector3(CAM_OFFSET_PERCENT * transform.origin.x, CAM_OFFSET_PERCENT * transform.origin.y, transform.origin.z) + CAM_OFFSET
	camera.look_at(transform.origin - transform.basis.z, Vector3.UP)


const ACCELERATION: float = 5.0
const BASE_SPEED: float = 40.0
const CAM_OFFSET: Vector3 = 2 * Vector3.UP + 12 * Vector3.BACK
const CAM_OFFSET_PERCENT: float = 0.95
const MAX_SPEED: float = 80.0
const MIN_SPEED: float = 6.0
const MOVEMENT_SPEED: float = 64.0
const TURN_MOD: float = 0.5 / MOVEMENT_SPEED
const TURN_SPEED: float = 2.0
