class_name Descriptions

const DOOR_LOCKED:String = "You try to the door, but some kind of magic shield prevents you from touching it; a low pitched tone rings out."
const LAMP_INACTIVE:String = "The lamp hovers above the door, dimly lit. You can barely make out anything around it, only the lamp."
const LAMP_ACTIVE:String = "The lamp hovers, brightly lit, like the lamp above the center of the room. You can see the door beneath it clearly."

static var descriptions:Dictionary
static var rooms:Dictionary


static func load():
	var json_as_text = FileAccess.get_file_as_string("res://ui/descriptions.json")
	if json_as_text.is_empty():
		print("open error: ", FileAccess.get_open_error())
	
	descriptions = JSON.parse_string(json_as_text)
	rooms = descriptions["rooms"]


static func get_room_text(room_name:String) -> String:
	return rooms[room_name.to_lower().replace("room","")]["text"]


static func get_token_text(room_name:String,token_name:String) -> String:
	return rooms[
		room_name.to_lower().replace("room","")
	]["tokens"][
		token_name.to_lower().replace("token","")
	]


static func get_interactable_text(room_name:String,interactable_name:String) -> String:
	return rooms[
		room_name.to_lower().replace("room","")
	]["interactables"][
		interactable_name.to_lower().replace("interactable","")
	]


static func get_door_text(room_name:String,door_name:String) -> String:
	return rooms[
		room_name.to_lower().replace("room","")
	]["doors"][
		door_name.to_lower().replace("door","")
		]
