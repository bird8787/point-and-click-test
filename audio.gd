extends Button

@onready var audio_container: VBoxContainer = $"../../Audio Container"

func _on_pressed() -> void:
	
	if audio_container.visible: audio_container.visible = false
	elif !audio_container.visible: audio_container.visible = true

	pass # Replace with function body.
