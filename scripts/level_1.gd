extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	adjust_scale()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func adjust_scale():
	# Screen dimensions
	var screen_size = get_viewport_rect().size
	var screen_width = screen_size.x
	var screen_height = screen_size.y
	
	# Calculate level dimensions
	var level_width = 44 * 16
	var level_height = 22 * 16
	
	# Calculate scale factors
	var scale_x = screen_width / float(level_width)
	var scale_y = screen_height / float(level_height)
	var scale_factor = min(scale_x, scale_y)
	
	# Set the scale
	scale = Vector2(scale_factor, scale_factor)
	
	# Center in the viewport
	var level_size = Vector2(level_width * scale_factor, level_height * scale_factor)
	var level_position = (screen_size - level_size) / 2
	
	if level_position.y < 0:
		level_position.y = 0
	
	position = level_position
	
	# Print debug information
	print("Viewport Size: ", Vector2(screen_width, screen_height))
	print("Level Size: ", Vector2(level_width, level_height))
	print("Scale: ", scale)
