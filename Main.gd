extends Spatial

var GRAVITY_SCALING = 10000000000

var gravity_objects 
var oldG = 6.674 * 0.000000000001
var G = oldG * GRAVITY_SCALING


func _ready():
	gravity_objects = [$Planet1, $Planet2]
	$LineDrawer.points = [$Planet1.transform.origin, $Planet2.transform.origin]
	$LineDrawer.enable(true)
	
func _process(delta):
	$LineDrawer.points = [$Planet1.transform.origin, $Planet2.transform.origin]

func _physics_process(delta):
	for x in range(gravity_objects.size()):
		for y in range(x+1, gravity_objects.size()):
			prints("x: ", x ," y: ", y)

			var object1 = gravity_objects[x]
			var object2 = gravity_objects[y]

			var magnitude = gravitational_force(object1, object2)

			var p1 = object1.transform.xform_inv(object2.global_transform.origin)
			var p2 = object2.transform.xform_inv(object1.global_transform.origin)

			object1.add_central_force(p1 * magnitude)
			object2.add_central_force(p2 * magnitude)
	print("end")
	
	
func gravitational_force(object1, object2) -> float:
	var squared_radius = (
		pow((object2.transform.origin.x - object1.transform.origin.x), 2) + 
		pow((object2.transform.origin.y - object1.transform.origin.y), 2) + 
		pow((object2.transform.origin.z - object1.transform.origin.z), 2)
	)
	var force = G * (object1.mass * object2.mass)/squared_radius
	return force
