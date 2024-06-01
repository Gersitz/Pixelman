extends TileMap

var speed = 25
var max_movement = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	
	if position.y >= max_movement:
		position.y = 0
