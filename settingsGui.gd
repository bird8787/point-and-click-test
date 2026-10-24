extends Button

@onready var settings: Control = $"../../Settings"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if settings.visible: settings.visible = false
	elif !settings.visible: settings.visible = true
