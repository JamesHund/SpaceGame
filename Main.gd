extends Spatial

var gravity_objects 
var G = 6.674* 0.01
#6.674 * 0.000000000001

func _ready():
	gravity_objects = [$Planet1, $Planet2]

func _physics_process(delta):
	for x in range(gravity_objects.size()):
		for y in range(x+1, gravity_objects.size()):
			prints("x: ", x ," y: ",y)
			var object1 = gravity_objects[x]
			var object2 = gravity_objects[y]
			var magnitude = gravitational_force(object1,object2)
			var p1 = object1.transform.xform_inv(object2.global_transform.origin)
			var p2 = object2.transform.xform_inv(object1.global_transform.origin)
			
			object1.add_central_force(p1*magnitude)
			object2.add_central_force(p2*magnitude)
	print("end")
	
	
func gravitational_force(object1, object2):
	var radius = pow((object2.transform.origin.x - object1.transform.origin.x),2) + pow((object2.transform.origin.y - object1.transform.origin.y),2) + pow((object2.transform.origin.z - object1.transform.origin.z),2)
	var force = G*object1.mass*object2.mass/radius
	return force
