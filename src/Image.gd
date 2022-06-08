extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	get_images()


func get_images():

	var path = "res://sequence/"
	print('Loading %s' % path)

	# Open Dir 
	var dir = Directory.new()
	if dir.open(path) == OK:
		print('PASS')
		# Iterate through directories (Skip navigational, Skip Hidden)
		dir.list_dir_begin(true,true) 
		# Get file name
		var file_name = dir.get_next()
		# Loop until no files left
		var i = 0
		while file_name != "":
			if !dir.current_is_dir():
				# Check if it's an ogg
				if '.png' in file_name and !".import" in file_name:
					# Trim suffix for load() function
					# var value = Global.load_texture(path + file_name)
					frames.add_frame("default", Global.load_texture(path + file_name), i)
			file_name = dir.get_next()
			i += 1

		Global.total_frames = frames.get_frame_count('default')

	else:
		print("Could not open %s" % path)

func _process(_delta):
	frame = Global.frame_driver