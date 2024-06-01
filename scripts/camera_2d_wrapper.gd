extends Camera2D

@export var level_width_in_tiles = 32
@export var level_height_in_tiles = 16
@export var tile_size = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()
	adjust_camera()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func adjust_camera():
	# Calculate level dimensions in pixels
	var level_width = level_width_in_tiles * tile_size
	var level_height = level_height_in_tiles * tile_size
	
	# Screen dimensions
	var screen_size = get_viewport().size
	var screen_width = screen_size.x
	var screen_height = screen_size.y
	
	#Calculate scale factors
	var scale_factor_width = screen_width / float(level_width)
	var scale_factor_height = screen_height / float(level_height)
	
	# Use the smaller scaler factor to fit the level within the window
	var scale_factor = min(scale_factor_width, scale_factor_height)
	
	# Apply the zoom to the camera
	zoom = Vector2(6.2 / scale_factor, 6.2 / scale_factor)
	
	# Center the camera on the level
	global_position = Vector2(level_width / 2, level_height / 2)
	
	# Print debug information
	print("Viewport Size: ", Vector2(screen_width, screen_height))
	print("Level Size: ", Vector2(level_width, level_height))
	print("Scale Factor: ", scale_factor)
