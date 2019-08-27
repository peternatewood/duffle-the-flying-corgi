extends Spatial

# PUBLIC


func handle_boundary_collision(position: Vector3):
	if position.y < BOUNDARY_RECT.position.y:
		position.y = BOUNDARY_RECT.position.y
	elif position.y > BOUNDARY_RECT.end.y:
		position.y = BOUNDARY_RECT.end.y

	if position.x > BOUNDARY_RECT.end.x:
		position.x = BOUNDARY_RECT.end.x
	elif position.x < BOUNDARY_RECT.position.x:
		position.x = BOUNDARY_RECT.position.x

	return position


const BOUNDARY_RECT: Rect2 = Rect2(Vector2(-80, -40), Vector2(160, 80))
