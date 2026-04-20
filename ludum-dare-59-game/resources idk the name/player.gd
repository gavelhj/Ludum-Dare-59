extends CharacterBody2D

@export var no_signal: bool
@export var jammed: bool

var move_dir = 0 # moving forward or backward
var rotate_dir = 0 # turning left or right

var move_start = 0
var move_end = 0

var rotate_start = 0
var rotate_end = 0

var alpha = 0 # movement timer
var animation_speed = 2
var movement_queued = false # give time for animation

func update_direction() -> void:
	move_dir = Input.get_axis('ui_down', 'ui_up')
	rotate_dir = Input.get_axis('ui_left', 'ui_right')

func _physics_process(delta) -> void:
	if not movement_queued:
		if not no_signal:
			update_direction()
		else:
			move_dir = 0
			rotate_dir = 0
		
		if jammed: # around 1 in 2 chance to get movement overwritten
			if randi_range(1, 2) >= 2:
				move_dir = randf() * randi_range(-1, 1)
				rotate_dir = randf() * randi_range(-1, 1)
			print("jammed")
		
		# prioritise rotating
		if abs(move_dir) - abs(rotate_dir) <= 0.1 and abs(rotate_dir) >= 0.3:
			movement_queued = true
			rotate_dir = 1 * sign(rotate_dir)
			move_dir = 0
			
			rotate_start = rotation
			rotate_end = rotation + deg_to_rad(rotate_dir * 90)
			
		elif abs(move_dir) >= 0.3:
			movement_queued = true
			move_dir = 1 * sign(move_dir)
			rotate_dir = 0
			
			move_start = position
			move_end = position + Vector2(cos(rotation), sin(rotation)) * globals.tile_size * move_dir
	
	if movement_queued:
		alpha += delta * globals.time_multipler * animation_speed
	
		if alpha > 1:
			alpha = 1
			
		if move_dir != 0:
			position = lerp(move_start, move_end, alpha)
			
		elif rotate_dir != 0:
			rotation = lerp(rotate_start, rotate_end, alpha)
			
	if alpha == 1:
		alpha = 0
		movement_queued = false
