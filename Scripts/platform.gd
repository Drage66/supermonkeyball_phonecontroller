extends Node3D
@onready var ball : RigidBody3D = %Ball
@onready var vis_rep = %track2
@onready var range_orbs : Node3D = $RangeOrbs
@onready var ball_range = ball.range_value
@onready var range_orbs_array

func _ready() -> void:
	range_orbs_array = range_orbs.get_children()

func _process(delta: float) -> void:
	for range_orb in range_orbs_array:
		if ball.global_position.distance_to(range_orb.global_position) < ball_range:
			# transform.basis = vis_rep.transform.basis
			# transform.basis = transform.basis.slerp(vis_rep.transform.basis, 0.2)
			transform.basis = lerp(transform.basis, vis_rep.transform.basis,0.2)


