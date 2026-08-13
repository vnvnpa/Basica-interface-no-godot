extends Node
class_name uiAnimationComponet

@export var animate_from_center : bool = true
@export var animate_scale : Vector2 = Vector2.ONE
@export var animation_duration:float = 0.1
@export var transition_type : Tween.TransitionType
@export var button_sound : AudioStream
@onready var audio_player := AudioStreamPlayer.new()


var target : Control
var default_scale : Vector2

func _ready() -> void:
	target = get_parent()
	call_deferred("setup")


func setup() -> void:
	target.mouse_entered.connect(_on_mouse_over)
	target.mouse_exited.connect(_on_mouse_out)
	if animate_from_center:
		target.pivot_offset = target.size / 2
		default_scale = target.scale


	if button_sound:
		audio_player.stream = button_sound
		add_child(audio_player)



func _on_mouse_over() -> void:
	init_tween("scale", animate_scale, animation_duration)

func _on_mouse_out() -> void:
	init_tween("scale", default_scale, animation_duration)




func init_tween(property: String, value, duration: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(target, property, value, duration).set_trans(transition_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
