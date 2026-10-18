extends Control

#inventory
@onready var inventoryLabel: RichTextLabel = $Inventory
@onready var itemStore: Array = getJsonAsDict("user://saveState.json")["itemStore"]
@onready var diologueStore: Array = getJsonAsDict("user://saveState.json")["diologueStore"]


#puzzlePieces
@onready var puzzlePiece1: ColorRect = $Inventory/GridContainer/ColorRect
@onready var puzzlePiece2: ColorRect = $Inventory/GridContainer/ColorRect2
@onready var puzzlePiece3: ColorRect = $Inventory/GridContainer/ColorRect3
@onready var puzzlePiece4: ColorRect = $Inventory/GridContainer/ColorRect4
#colors
@onready 	var colors = ["#00000000","#ffffffff"]

@onready var rooms = [
	"res://Rooms/outSide.tscn",
	"res://Rooms/insideHouse.tscn"

]

func getJsonAsDict(PATH: String):
	var file = FileAccess.open(PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			return(data_received)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

func autoSave():
	var PATH = "user://saveState.json"
	var json_string = inventory
	var save_state = getJsonAsDict("user://saveState.json")
	var file = FileAccess.open(PATH, FileAccess.WRITE_READ)
	print(save_state)
	save_state["inventory"] = json_string
	
	var scene_path = get_parent().get_scene_file_path()
	print(rooms.find(scene_path, 0))
	print(scene_path)
	save_state["room"] = rooms.find(scene_path, 0)
	save_state["itemStore"] = itemStore
	save_state["diologueStore"] = diologueStore

	file.store_string(JSON.stringify(save_state))
	pass

func addItemToInventory(item: Dictionary, id: int, diologuePath: String): #grackle script
	var inventoryToSetTo = inventory["items"]
	
	var foundMatch = false
	#max id of 251
	var bitSetId = 0
	
	if (id) < 63:
		bitSetId = 0
	elif (id) < 126:
		bitSetId = 1
	elif (id) < 189:
		bitSetId = 2
	else:
		bitSetId = 3
	var bitSetToUse = (itemStore[bitSetId])
	print(itemStore, itemStore[bitSetId], " ", typeof(itemStore[bitSetId]))
	var newBitSet = bitSetToUse
	id = id % 63
	for x in len(inventory["items"]):
		#do stuff
		if is_bit_active(id, bitSetToUse):
			print("item " + item["name"] + " was empty")
			foundMatch = true
	if not foundMatch:
		
		inventoryToSetTo.append(item)
		newBitSet = setBit.new(id, bitSetToUse).bits
		print("gave " + item["name"] + " to player")
		if diologuePath != "":
			displayDiologe(diologuePath, -1)
	itemStore[bitSetId] = newBitSet
	inventory["items"] = inventoryToSetTo
	generateInventory()
	pass
func displayDiologe(diologuePath: String, id: int): #grackle script	
	#max id of 251
	if id == -1:
		Dialogic.start(diologuePath)
	else:
		var bitSetId = 0
		
		if (id) < 63:
			bitSetId = 0
		elif (id) < 126:
			bitSetId = 1
		elif (id) < 189:
			bitSetId = 2
		else:
			bitSetId = 3
		var bitSetToUse = (diologueStore[bitSetId])
		print(diologueStore, diologueStore[bitSetId], " ", typeof(diologueStore[bitSetId]))
		var newBitSet = bitSetToUse
		id = id % 63
		if not is_bit_active(id, bitSetToUse):
			newBitSet = setBit.new(id, bitSetToUse).bits
			Dialogic.start(diologuePath)
		diologueStore[bitSetId] = newBitSet


class setBit:
	var mask
	var bits
	func _init(index, p):
		bits = int(p)
		mask = 1 << index
		if not bits & mask:
			bits = bits | mask

func to_binary(intValue: int) -> String:
	var bin_str: String = ""
	while intValue > 0:
		bin_str = str(intValue & 1) + bin_str
		intValue = intValue >> 1
	return bin_str
	
func is_bit_active(index: int, bitset: int) -> bool:
	return (bitset & (1 << index)) > 0

var inventory = getJsonAsDict("user://saveState.json")["inventory"]

func _ready() -> void:
	inventoryLabel.visible = false
	generateInventory()


func generateInventory():
	var screenstuff = ""
	
	for item in inventory["items"]:
		
		#do stuff
		screenstuff = screenstuff + item["name"] + " x" + str(int(item["quantity"])) + "\n"
	if screenstuff == "":
		screenstuff = "you own NOTHING"
	#Render Puzzle Piece
	puzzlePiece1.color = colors[int(is_bit_active(0, int(inventory["puzzlePieces"])))]
	puzzlePiece2.color = colors[int(is_bit_active(1, int(inventory["puzzlePieces"])))]
	puzzlePiece3.color = colors[int(is_bit_active(2, int(inventory["puzzlePieces"])))]
	puzzlePiece4.color = colors[int(is_bit_active(3, int(inventory["puzzlePieces"])))]
	
	inventoryLabel.text = screenstuff


func _on_inventory_open() -> void:
	if inventoryLabel.visible: inventoryLabel.visible = false
	else: inventoryLabel.visible = true
	puzzlePiece1.color = colors[int(is_bit_active(0,int(inventory["puzzlePieces"])))]
	puzzlePiece2.color = colors[int(is_bit_active(1,int(inventory["puzzlePieces"])))]
	puzzlePiece3.color = colors[int(is_bit_active(2,int(inventory["puzzlePieces"])))]
	puzzlePiece4.color = colors[int(is_bit_active(3,int(inventory["puzzlePieces"])))]

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# Call your function here
		autoSave()
		get_tree().quit()  # Proceed to quit the game
