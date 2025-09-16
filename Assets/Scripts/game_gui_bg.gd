extends ColorRect


func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Global.screen_approached:
		visible = true
