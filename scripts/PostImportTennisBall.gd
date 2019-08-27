tool
extends EditorScenePostImport


func post_import(scene):
	# Add sphere collider

	var sphere_shape = SphereShape.new()
	sphere_shape.set_radius(0.1)

	var collision_shape = CollisionShape.new()
	collision_shape.set_shape(sphere_shape)

	scene.add_child(collision_shape)
	collision_shape.set_owner(scene)

	return scene
