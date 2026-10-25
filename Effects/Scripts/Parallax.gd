extends Sprite2D

@onready var parallax_2d: Parallax2D = $"../Parallax2D"
@onready var parallax_2d_2: Parallax2D = $"../Parallax2D2"
@onready var parallax_2d_3: Parallax2D = $"../Parallax2D3"

@onready var scroll: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	scroll += Vector2(100 * delta, 0)
	
	parallax_2d_3.scroll_offset = (Vector2(getMousePos() - getScreenSize()) + scroll) / 5
	parallax_2d_2.scroll_offset = (Vector2(getMousePos() - getScreenSize()) + scroll) / 7
	parallax_2d.scroll_offset = (Vector2(getMousePos() - getScreenSize()) + scroll) / 9

	pass
func getScreenSize():
	return Vector2((0 - Vector2(get_viewport().get_visible_rect().size).x), Vector2(get_viewport().get_visible_rect().size).y)

func getMousePos() -> Vector2:
	var mouseX = clamp(get_viewport().get_mouse_position().x, 0, 0 - getScreenSize().x)
	
	var mouseYI = getScreenSize().y * 0.25 + (getScreenSize().y * 0.75 - getScreenSize().y * 0.25) * (get_viewport().get_mouse_position().y/ getScreenSize().y)
	var mouseY = clamp(mouseYI, 0, getScreenSize().y)

	return Vector2(mouseX, mouseY)

#interpolation = 
