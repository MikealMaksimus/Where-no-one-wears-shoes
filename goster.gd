extends Node

const SAVE_PATH = "user://savse.json"

# Data that will be saved
var save_data = {
	"opend": false
}


func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))


func load_game():
	if !FileAccess.file_exists(SAVE_PATH):
		print("No save file found")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())

	if error == OK:
		save_data = json.data
		# Now update Info.opend AFTER loading JSON
		Info.opend = save_data.get("opend", false)
	else:
		print("JSON parse error")


func open(value: bool):
	save_data["opend"] = value
	Info.opend = value   # keep Info in sync immediately
	save_game()


func is_opened() -> bool:
	return save_data.get("opend", false)
