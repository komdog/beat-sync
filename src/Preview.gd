extends Node2D

onready var image: AnimatedSprite = $Image

# Called when the node enters the scene tree for the first time.
func _ready():
	get_info()


func _input(event):
	if event.is_action_pressed('ui_accept'):
		$Image.play()
		$Music.play()
		$Bar.visible = false
		
func get_info():
	var c = ConfigFile.new()
	if c.load(Global.cur_dir + 'config.cfg') == OK:
		Global.bpm = c.get_value("data", "bpm", 0.0)
		Global.offset = c.get_value("data", "offset", 0.0)
		Global.loops_per_beat = c.get_value("data", "loops", 1)
	else:
		print("Could not load config")
