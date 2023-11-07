extends VBoxContainer

@onready var eventLog = $LogMargin/LogScroll/LogText
@onready var btn_1 = $"ButtonContainer/Option 1"
@onready var btn_2 = $"ButtonContainer/Option 2"
@onready var btn_3 = $"ButtonContainer/Option 3"

var story_paths_dict = read_json_file("res://texts/storyPaths.json")
var last_option_selected: String = ""

func _ready():
	if !story_paths_dict:
		print("nicht da")
		return
	
	write_to_log(story_paths_dict["0"].text)
	btn_1.text = story_paths_dict["1"].button_title
	btn_2.text = story_paths_dict["2"].button_title
	btn_3.text = story_paths_dict["3"].button_title





# READ FROM FILE
func read_json_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = JSON.parse_string(content_as_text)
	return content_as_dictionary


# WRITE TO LOG
func write_new_lines_to_eventlog(quantity: int):
	while quantity != 0:
		eventLog.newline()
		quantity -= 1

func write_to_log(text):
	write_new_lines_to_eventlog(4)
	eventLog.append_text("".join(text))
	write_new_lines_to_eventlog(8)


# GET DATA
func get_data_from_current_story_path_dir_pos():
	if Globals.choice_path.is_empty():
		print("choice_path is empty")
		return
		
	var current_path_pos = Globals.choice_path
	var path_pos_data = story_paths_dict[current_path_pos]
	return path_pos_data



# GAME LOGIC
func option_choosen(option: String):
	var choice_path = Globals.choice_path
	choice_path += option
	
	if story_paths_dict[choice_path].has("text"):
		write_to_log(story_paths_dict[choice_path].text)
	elif !story_paths_dict[choice_path].has("text"):
		return
	
	if story_paths_dict.has(choice_path + "1"):
		btn_1.text = story_paths_dict[choice_path + "1"].button_title
	elif !story_paths_dict.has(choice_path + "1"):
		btn_1.text = "Error 1"
		btn_2.text = "Error 2"
		btn_3.text = "Error 3"
		return

	if story_paths_dict.has(choice_path + "2"):
		btn_2.text = story_paths_dict[choice_path + "2"].button_title
	elif !story_paths_dict.has(choice_path + "2"):
		btn_1.text = "Error 1"
		btn_2.text = "Error 2"
		btn_3.text = "Error 3"
		return

	if story_paths_dict.has(choice_path + "3"):
		btn_3.text = story_paths_dict[choice_path + "3"].button_title
	elif !story_paths_dict.has(choice_path + "3"):
		btn_1.text = "Error 1"
		btn_2.text = "Error 2"
		btn_3.text = "Error 3"
		return
	
	Globals.choice_path = choice_path


func _on_option_1_pressed():
	option_choosen("1")

func _on_option_2_pressed():
	option_choosen("2")

func _on_option_3_pressed():
	option_choosen("3")

