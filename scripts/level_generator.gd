extends Node2D

@export var width: int = 50
@export var height: int = 50

@onready var ground_map: TileMapLayer = $GroundMapLayer

# Terrain indices from your TileSet
@export var terrain_set: int = 0      # index of TerrainSet
@export var terrain_grass: int = 0    # index of Terrain inside that set

# Noise parameters
@export var frequency: float = 0.05
@export var threshold: float = 0.0

var noise: FastNoiseLite

func _ready():
	randomize()
	_setup_noise()
	_generate_terrain()

func _setup_noise():
	noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = frequency   # controls size of features

func _generate_terrain():
	ground_map.clear()

	var cells: Array[Vector2i] = []

	for x in width:
		for y in height:
			var n = noise.get_noise_2d(x, y)
			if n > threshold:
				cells.append(Vector2i(x, y))

	# Correct order: cells first, then terrain_set, terrain
	ground_map.set_cells_terrain_connect(cells, terrain_set, terrain_grass, true)
