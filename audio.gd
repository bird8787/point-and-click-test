extends Button

@onready var audio_container: VBoxContainer = $"../../Audio Container"
@onready var controls_container: VBoxContainer = $"../../Controls Container"
@onready var visuals_container: VBoxContainer = $"../../Visuals Container"

func _on_pressed() -> void:
	
	if audio_container.visible:
		audio_container.visible = false
	elif !audio_container.visible:
		audio_container.visible = true
		controls_container.visible = false
		visuals_container.visible = false

	pass # Replace with function body.
