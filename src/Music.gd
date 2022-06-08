extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_audio_files()

func get_audio_files():

	var path = "res://music/"

	# Open Dir 
	var dir = Directory.new()
	if dir.open(path) == OK:
		# Iterate through directories (Skip navigational, Skip Hidden)
		dir.list_dir_begin(true,true) 
		# Get file name
		var file_name = dir.get_next()
		# Loop until no files left
		while file_name != "":
			if !dir.current_is_dir():
				# Check if it's an ogg
				if '.ogg' in file_name and !".import" in file_name:
					stream = load_ogg(path + file_name)
			file_name = dir.get_next()

		print(stream)
			
	else:
		print("Could not open %s" % path)
	

func load_ogg(path):
	# Load OGG file
	var ogg_file = File.new()
	if ogg_file.open(path, File.READ) != OK: return print("Cound not locate file: " + path)
	var bytes = ogg_file.get_buffer(ogg_file.get_len())
	var audio_stream = AudioStreamOGGVorbis.new()
	audio_stream.data = bytes
	ogg_file.close()
	# Util.log("Loaded OGG: " + path)
	return audio_stream

var song_position: float = 0.0
var synced_position: float = 0.0
var wrapped_position: float = 0.0
var remapped_position: float = 0.0

func _process(_delta):
		
	if playing: 

		# Get raw song position for pausing
		song_position = (
			get_playback_position() 
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
			+ Global.offset
		)
		
		synced_position = song_position / (60/Global.bpm)
		wrapped_position = wrapf( synced_position , 0.0 , 1.0 )
		remapped_position = (wrapped_position - 0.0) / (1.0 - 0.0) * (float(Global.total_frames) - 0.0) + 0.0
		Global.frame_driver = int(floor(remapped_position))
		# result = (value - InputA) / (InputB - InputA) * (OutputB - OutputA) + OutputA

		print( Global.frame_driver )
			
