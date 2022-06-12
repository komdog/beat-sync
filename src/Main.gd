extends Control

func _ready():
	if $HTTPRequest.connect("request_completed", self, "_on_request_completed") == OK: pass
	$HTTPRequest.request("https://api.github.com/repos/komdog/beat-sync/git/refs/tags")
	

func _on_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse(body.get_string_from_utf8())

	var tag_data = JSON.print(json.result.back()['ref'], "\t")
	var stripped_tag_data = tag_data.replace('"refs/tags/v', '')
	var version_latest = float(stripped_tag_data)

	print( "Latest Version: %s" % version_latest )
	if version_latest > ProjectSettings.get_setting('global/Version'):
		$Popup/Panel/Label2.text = "Your Version: v%s / Latest v%s" % [ProjectSettings.get_setting('global/Version'), version_latest]
		$Popup.popup()
	else:
		$Label.text = "Loading..."
		yield(get_tree(), "idle_frame") #This idle frame
		if get_tree().change_scene("res://src/Preview.tscn") == OK: pass


func _on_Ignore_button_up():
	$Popup.visible = false
	yield(get_tree(), "idle_frame") #This idle frame
	$Label.text = "Loading..."
	yield(get_tree(), "idle_frame") #This idle frame
	if get_tree().change_scene("res://src/Preview.tscn") == OK: pass


func _on_Update_button_up():
	if OS.shell_open('https://github.com/komdog/beat-sync/releases') == OK:
		get_tree().quit()
