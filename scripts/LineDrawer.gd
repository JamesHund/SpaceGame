extends ImmediateGeometry

var points

func enable(enabled : bool):
	set_process(enabled)

func _process(delta):
	clear()
	begin(Mesh.PRIMITIVE_LINE_STRIP)
	set_color(Color.red)
	for i in points:
		add_vertex(i)
	end()
	
	
