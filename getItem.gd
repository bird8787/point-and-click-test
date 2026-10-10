extends Button

@export var itemName: String
@export var number: int
@export var gui_node: Control

@onready var item: Dictionary = {
	"name":itemName,
	"quantity":number,
	"spent": "false"
}

func _on_pressed() -> void:
	item = {
		"name":itemName,
		"quantity":number,
		"spent": "false"
	}

	gui_node.addItemToInventory(item)
