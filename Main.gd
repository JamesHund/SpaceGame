extends Spatial

var GRAVITY_SCALING = 10000000000

var gravity_objects 
var oldG = 6.674 * 0.000000000001
var G = oldG * GRAVITY_SCALING


func _ready():
	gravity_objects = [$Planet1, $Planet2]
	simulate_movement(gravity_objects, 60)

func _physics_process(delta):
#	var force_changes = calcute_all_forces(gravity_objects)
#	for object in gravity_objects:
#		object.add_central_force(force_changes[object])
#	print("end")
	for x in range(gravity_objects.size()):
		for y in range(x+1, gravity_objects.size()):
			var object1 = gravity_objects[x]
			var object2 = gravity_objects[y]

			var magnitude = gravitational_force(object1, object2)

			var p1 = object1.transform.xform_inv(object2.global_transform.origin)
			var p2 = object2.transform.xform_inv(object1.global_transform.origin)

			object1.add_central_force(p1 * magnitude)
			object1.add_central_force(p2 * magnitude)

func calcute_all_forces(gravity_objects):
	var force_changes = {}
	for x in range(gravity_objects.size()):
		for y in range(x+1, gravity_objects.size()):

			var object1 = gravity_objects[x]
			var object2 = gravity_objects[y]

			var magnitude = gravitational_force(object1, object2)

			var p1 = object1.transform.xform_inv(object2.global_transform.origin)
			var p2 = object2.transform.xform_inv(object1.global_transform.origin)

			force_changes[object1] = p1 * magnitude
			force_changes[object2] = p2 * magnitude

func calcute_all_forces_clean(objects):
	for x in range(objects.size()):
		for y in range(x+1, objects.size()):

			var object1 = objects[x]
			var object2 = objects[y]

			var magnitude = gravitational_force_clean(object1, object2)

			var p1 = object1[0].xform_inv(object2[0].origin)
			var p2 = object2[0].xform_inv(object1[0].origin)

			object1[3] += p1 * magnitude
			object2[3] += p2 * magnitude

func gravitational_force(object1, object2) -> float:
	var squared_radius = (
		pow((object2.transform.origin.x - object1.transform.origin.x), 2) + 
		pow((object2.transform.origin.y - object1.transform.origin.y), 2) + 
		pow((object2.transform.origin.z - object1.transform.origin.z), 2)
	)
	var force = G * (object1.mass * object2.mass)/squared_radius
	return force

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
	var time_scale = 1.0/60
	for run in range(number):
		prints("--------Step %s------" % (run+1))
		calcute_all_forces_clean(object_tings)
		for object in object_tings:
			var postion_x = object[0].origin.x
			var postion_y = object[0].origin.y
			var postion_z = object[0].origin.z
			var velocity_x = object[1].x
			var velocity_y = object[1].y
			var velocity_z = object[1].z
			var new_position_offset_u = Vector3(
				velocity_x * time_scale,
				velocity_y * time_scale,
				velocity_z * time_scale
			)
			var new_position_offset_v = Vector3(
				0.5 * object[3].x/object[2] * pow(time_scale, 2),
				0.5 * object[3].y/object[2] * pow(time_scale, 2),
				0.5 * object[3].z/object[2] * pow(time_scale, 2)
			)
			draw_line(object[4], object[0].origin,object[0].origin+new_position_offset_u+new_position_offset_v)
			object[0][3] =  object[0][3] + new_position_offset_u+new_position_offset_v


func draw_line(name, start: Vector3, end: Vector3):
	
	prints(name, start,end)

