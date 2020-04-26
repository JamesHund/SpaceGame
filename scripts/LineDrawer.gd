extends ImmediateGeometry

var points = []

func _ready():
	set_process(false)
	
func enable(enabled : bool):
	set_process(enabled)

func _process(_delta):
	clear()
	begin(Mesh.PRIMITIVE_LINES)
	set_color(Color.red)
	for i in points:
		add_vertex(i)
	end()
	
	
