extends Node

# Get Current Directory Based on game location
var exe_path = OS.get_executable_path().get_base_dir()
var debug_path = ProjectSettings.globalize_path("res://")
var cur_dir = exe_path + "/" if OS.is_debug_build() == false else debug_path


var bpm: float = 0
var offset: float = 0
var loops_per_beat: float = 1.0
var frame_driver: int = 0
var total_frames: int = 0

func load_texture(path) -> ImageTexture:
	var dir = Directory.new()
	if !dir.file_exists(path): return print("No image found at D: %s" % path)
	# Create classes
	var img = Image.new()
	img.load(path)

	var tex = ImageTexture.new()
	tex.create_from_image(img)
	return tex

