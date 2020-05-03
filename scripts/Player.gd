extends Spatial


onready var pos = -1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func process(delta):
	print($AnimationTree.get("parameters/Anim/blend_position"))
	$AnimationTree.set("parameters/Anim/blend_position", pos)
	pos += delta
