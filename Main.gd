extends Spatial

# https://github.com/godotengine/godot/blob/058a0afdeca83145d58a95c426dd01216c397ea9/servers/physics_3d/body_3d_sw.cpp
# transform.origin += total_linear_velocity * p_step;
# linear_velocity += _inv_mass * force * p_step;
# linear_velocity *= damp;
# real_t damp = 1.0 - p_step * area_linear_damp;
# where area_linear_damp = -1

export var gravity_scaling = 1

var gravity_objects 
var oldG = 0.6674
var G

var count = 0

func _ready():
	G = oldG * gravity_scaling
	gravity_objects = []
	for node in get_children():
		if(node is RigidBody):
			gravity_objects.append(node)
	print(gravity_objects)
	simulate_movement(gravity_objects, 10000)
	$LineDrawer.enable(true)


func _process(_delta):
	pass

func _physics_process(_delta):
	count += 1
	for x in range(gravity_objects.size()):
		for y in range(x+1, gravity_objects.size()):

			var object1 = gravity_objects[x]
			var object2 = gravity_objects[y]

			var magnitude = gravitational_force(object1, object2)

			var p1 = object1.transform.xform_inv(object2.global_transform.origin).normalized()
			var p2 = object2.transform.xform_inv(object1.global_transform.origin).normalized()

			object1.add_central_force(p1 * magnitude)
			object2.add_central_force(p2 * magnitude)


func gravitational_force(object1, object2) -> float:
	var squared_radius = (
		pow((object2.transform.origin.x - object1.transform.origin.x), 2) + 
		pow((object2.transform.origin.y - object1.transform.origin.y), 2) + 
		pow((object2.transform.origin.z - object1.transform.origin.z), 2)
	)
	var force = G * (object1.mass * object2.mass)/squared_radius
	return force


func calcute_all_forces_clean(objects):
	for object in objects:
		object[3]=Vector3(0,0,0)
	for x in range(objects.size()):
		for y in range(x+1, objects.size()):

			var object1 = objects[x]
			var object2 = objects[y]

			var magnitude = gravitational_force_clean(object1, object2)

			var p1 = object1[0].xform_inv(object2[0].origin).normalized()
			var p2 = object2[0].xform_inv(object1[0].origin).normalized()

			object1[3] += p1 * magnitude
			object2[3] += p2 * magnitude


func gravitational_force_clean(object1, object2) -> float:
	var squared_radius = (
		pow((object2[0].origin.x - object1[0].origin.x), 2) + 
		pow((object2[0].origin.y - object1[0].origin.y), 2) + 
		pow((object2[0].origin.z - object1[0].origin.z), 2)
	)
	var force = G * (object1[2] * object2[2])/squared_radius
	return force

func simulate_movement(all_objects: Array, number: int):
	var object_tings = []
	for object in all_objects:
		object_tings.append([object.transform, object.get_linear_velocity(), object.mass, Vector3(0,0,0), object.get_name()])
	var time_step = 1.0/60
	for run in range(number):

		calcute_all_forces_clean(object_tings)
		for object in object_tings:
			var velocity = object[1]
			var mass = object[2]
			var force = object[3]
			var position = object[0][3]
			velocity += force/mass * time_step
			position += velocity * time_step
			draw_line(object[4], object[0].origin,position)
			object[0][3] =  position
			object[1] = velocity


func draw_line(name, start: Vector3, end: Vector3):
	$LineDrawer.points.append(start)
	$LineDrawer.points.append(end)
#	prints(name, start,end)

