extends Button



@onready var settings: Control = $"../../Settings"


func _on_pressed() -> void:
	if settings.visible: settings.visible = false
	elif !settings.visible: settings.visible = true

	pass # Replace with function body.
