extends Sprite2D

@onready var parallax_2d: Parallax2D = $"../Parallax2D"
@onready var parallax_2d_2: Parallax2D = $"../Parallax2D2"
@onready var parallax_2d_3: Parallax2D = $"../Parallax2D3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	parallax_2d_3.scroll_offset = Vector2(get_viewport().get_mouse_position() - getScreenSize()) / 5
	parallax_2d_2.scroll_offset = Vector2(get_viewport().get_mouse_position() - getScreenSize()) / 7
	parallax_2d.scroll_offset = Vector2(get_viewport().get_mouse_position() - getScreenSize()) / 9

	pass
func getScreenSize():
	return Vector2((0 - Vector2(DisplayServer.screen_get_size()).x / 2), Vector2(DisplayServer.screen_get_size()).y / 4)
