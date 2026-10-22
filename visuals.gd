extends Button
@onready var visuals_container: VBoxContainer = $"../../Visuals Container"
@onready var audio_container: VBoxContainer = $"../../Audio Container"
@onready var controls_container: Button = $"../Controls"


func _on_pressed() -> void:
	if visuals_container.visible:
		visuals_container.visible = false
	elif !visuals_container.visible:
		visuals_container.visible = true
		audio_container.visible = false
		controls_container.visible = false
