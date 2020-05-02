tool
extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var PLANET_SCALE = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance.scale = Vector3(1,1,1)*PLANET_SCALE
	$CollisionShape.scale = Vector3(1,1,1)*PLANET_SCALE
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#code to be run in editor
	if Engine.editor_hint:
		$MeshInstance.scale = Vector3(1,1,1)*PLANET_SCALE
		$CollisionShape.scale = Vector3(1,1,1)*PLANET_SCALE
	
