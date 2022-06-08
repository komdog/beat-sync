extends Node

var bpm: float = 0
var offset: float = 0
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

