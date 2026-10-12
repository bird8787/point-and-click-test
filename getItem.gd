extends Button

@export var itemName: String
@export var number: int
@export var id: int
@export var gui_node: Control

@onready var item: Dictionary = {
	"name":itemName,
	"quantity":number,
}

func _on_pressed() -> void:
	item = {
		"name":itemName,
		"quantity":number,
	}

	gui_node.addItemToInventory(item, id)
