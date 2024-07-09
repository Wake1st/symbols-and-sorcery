class_name Descriptions

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
