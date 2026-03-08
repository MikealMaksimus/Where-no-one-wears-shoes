extends StaticBody3D

var price := 3

func consume():
	get_parent().interact()
