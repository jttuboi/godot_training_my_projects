extends Node

const Npc = preload('res://src/npc.tscn')
const NAMES = [ 'jao', 'pedro', 'zeca', 'zé', 'mateus', 'jair', 'jonas', 'juca', 'jeremias', 'tonhão', 'alex', 'adriano', 
				'luis', 'lucas', 'luciano', 'davi', 'artur', 'gabriel', 'abel', 'adam', 'miguel', 'guilherme', 'enzo', 
				'felipe', 'rafael', 'daniel', 'murilo', 'vinicius', 'leandro', 'caio', 'bruno', 'eric', 'igor', 'renato' ]
var next_name = 0

onready var Objects = get_parent().get_node('Objects')

var npcs_time = [ '000ySUMs01d08h12m', '000ySUMs01d09h01m' ]


func _ready():
	Signals.connect('minute_changed', self, 'on_TimeSystem_minute_changed')
	randomize()


func on_TimeSystem_minute_changed(time_data: TimeData):
	for npc_time in npcs_time:
		if time_data.is_equal_time_id(npc_time):
			create_npc()


func create_npc() -> Npc:
	var npc = Npc.instance()
	npc.title = NAMES[next_name]
	npc.position = Vector2(randi() % 300 + 200, randi() % 300 + 200)
	Objects.add_child(npc)
	
	next_name += 1
	
	return npc
