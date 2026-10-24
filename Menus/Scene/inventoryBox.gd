extends HBoxContainer

	
func _ready() -> void:
	showInventoryChildren([])

func sizeBox() -> void:
	var childCount = 0
	
	for child in get_children():
		if child.visible:
			childCount += 1
	self.custom_minimum_size.x = childCount * 155
func showInventoryChildren(inventory: Array):
	var i = 0
	for child in get_children():
		if i > len(inventory) - 1:
			child.visible = false
		else:
			var item = inventory[i]
			child.showItem(item["imagePath"], item["name"], item["quantity"])
			child.visible = true
		i += 1
	sizeBox()
	pass
