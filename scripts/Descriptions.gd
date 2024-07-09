class_name Descriptions

static var descriptions:Dictionary
static var rooms:Dictionary


static func load():
	var json_as_text = FileAccess.get_file_as_string("res://ui/descriptions.json")
	if json_as_text.is_empty():
		print("open error: ", FileAccess.get_open_error())
	
	descriptions = JSON.parse_string(json_as_text)
	for room in descriptions["rooms"]:
		rooms[room.name] = room


static func get_room_text(name:String) -> String:
	var n = name.to_lower().replace("room","")
	var room = rooms[name.to_lower().replace("room","")]
	print("name: %s\t| room: %s" % [n, room])
	return room["text"]
