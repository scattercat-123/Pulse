extends ColorRect


func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if Global.screen_approached:
		visible = true
