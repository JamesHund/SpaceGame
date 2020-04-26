extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var PLANET_SCALE = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector3(PLANET_SCALE,PLANET_SCALE,PLANET_SCALE)
	$MeshInstance.scale = scale
	$CollisionShape.scale = scale
	mass = mass * pow(PLANET_SCALE,3)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
