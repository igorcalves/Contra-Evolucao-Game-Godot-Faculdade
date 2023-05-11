extends Node2D

const  FOAM: PackedScene = preload("res://ContraEvolucao/management/foam.tscn")
const  DEFAULT_LAYER: int = 0

@onready var grass_tilemap: TileMap = get_node("Grass")
@onready var water_tilemap: TileMap = get_node("Water")

var grass_used_cell: Array
var water_used_cells:Array




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	var use_grass_rect: Rect2 = grass_tilemap.get_used_rect()
	grass_used_cell = grass_tilemap.get_used_cells(0)
	generate_water_tiles(use_grass_rect)
	generated_foam_tiles()

	
func generate_water_tiles(used_rect: Rect2) -> void:
	for x in range (used_rect.position.x -10, used_rect.size.x +10):
		for y in range (used_rect.position.y -10, used_rect.size.y +10):
			if grass_used_cell.has(Vector2i(x,y)):
				continue
			water_tilemap.set_cell(DEFAULT_LAYER, Vector2i(x,y), DEFAULT_LAYER,Vector2i(0,0))
			
	water_used_cells =  water_tilemap.get_used_cells(DEFAULT_LAYER)
	
	
	
func generated_foam_tiles() -> void:
	for cell in grass_used_cell:
		if check_grass_neighbors(cell):
			spawn_foam(cell)
		

func check_grass_neighbors(cell:Vector2i) -> bool:
	var left_neighbor: Vector2i = Vector2(cell.x - 1, cell.y)
	var right_neighbor: Vector2i = Vector2(cell.x + 1, cell.y)
	var up_neighbor: Vector2i = Vector2(cell.x, cell.y - 1)
	var bottom_neighbor: Vector2i = Vector2(cell.x, cell.y + 1)
	
	var neighors_list: Array = [left_neighbor, right_neighbor, up_neighbor, bottom_neighbor]
	
	for neighbor in neighors_list:
		if water_used_cells.has(neighbor):
			return true
	return false
		
func spawn_foam(foam_cell:Vector2)-> void:
	var foam = FOAM.instantiate()
	foam.position = foam_cell * 64.0 + Vector2(32,32)
	add_child(foam)
