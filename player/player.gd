class_name Player
extends Node3D

signal entered_room()
signal hovered_over(collider_id:int)
signal selection_attempted(result:Dictionary)
signal spell_cast(spell:Spells.TYPE,collider_id:int)

const RAY_LENGTH = 1000

@export_category("Player")
@export var travel_time:float = 3.2
@export var verticle_look_clamp:Vector2 = Vector2(-0.9,0.9)
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sensitivity: float = 1

@onready var camera:Camera3D = $Camera
@onready var itemPickup:ItemPickup = %ItemPickup
@onready var spellCaster:SpellBase = %SpellCaster
@onready var wand:Wand = %Wand

var cursor_in_game:bool = false
var is_looking_around:bool = false
var is_traveling:bool = false
var translate_tween:Tween
var rotate_tween:Tween

var just_hit_interactable:bool = false
var just_hit_id:int = 0


func go_to(point:NavPoint) -> void:
	if !is_traveling:
		is_traveling = true
		
		translate_tween = create_tween()
		translate_tween.tween_property(
			self,"global_position",point.global_position,travel_time
		).set_ease(Tween.EASE_IN_OUT
		).set_trans(Tween.TRANS_QUAD)
		
		rotate_tween = create_tween()
		rotate_tween.tween_property(
			camera,"global_basis",point.global_basis,travel_time
		).set_ease(Tween.EASE_IN_OUT
		).set_trans(Tween.TRANS_QUAD)


func pick_up(thing:TokenBase) -> void:
	itemPickup.pick_up(thing)


func arm_spell(newSpell:Spells.TYPE) -> void:
	#	no change or turn off
	if newSpell == wand.active_spell:
		return
	elif spellCaster.is_on:
		spellCaster.cast()
	
	#	set new spell
	spellCaster.change_spell(newSpell)
	
	#	setup wand and new spell
	wand.active_spell = newSpell


func _ready() -> void:
	spellCaster.finished.connect(_handled_spell_finished)


func _physics_process(_delta) -> void:
	if is_traveling:
		is_traveling = translate_tween.is_running()
		
		#	single update for finished traveling
		if !is_traveling:
			entered_room.emit()


func _input(_event) -> void:
	if !cursor_in_game:
		return
	
	is_looking_around = !is_traveling && Input.is_action_pressed("free_look")
	
	if !is_traveling && !is_looking_around:
		var space_state = get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		
		var origin = camera.project_ray_origin(mousepos)
		var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		
		var result = space_state.intersect_ray(query)
		if !result.is_empty():
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				if wand.try_cast():
					just_hit_id = result.collider_id
					just_hit_interactable = spellCaster.cast(result.position)
				elif !wand.is_equipped:
					selection_attempted.emit(result)
			else:
				hovered_over.emit(result.collider_id)


func _unhandled_input(event) -> void:
	if is_looking_around && event is InputEventMouseMotion:
		var look_dir = event.relative * 0.04
		camera.rotation.y -= look_dir.x * camera_sensitivity
		camera.rotation.x = clamp(
			camera.rotation.x - look_dir.y * camera_sensitivity,
			verticle_look_clamp.x,
			verticle_look_clamp.y
		)


func _handled_spell_finished() -> void:
	wand.spell_finished()
	
	if just_hit_interactable:
		spell_cast.emit(wand.active_spell, just_hit_id)
		
		just_hit_interactable = false
		just_hit_id = 0
