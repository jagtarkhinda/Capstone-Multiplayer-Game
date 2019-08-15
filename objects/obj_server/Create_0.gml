//init server
#macro PORT		5646
#macro MAX_CLIENTS	4

//tanks to select
#macro TANK_CHARACTER_RED		0
#macro TANK_CHARACTER_GREEN		1
#macro TANK_CHARACTER_BLUE		2
#macro TANK_CHARACTER_YELLOW	3

//packets
#macro PACKET_KEY		0
#macro PACKET_ENTITY	1
#macro PACKET_NAME		2
#macro PACKET_TANK_CHARACTER 3
#macro PACKET_PLAY		4
#macro PACKET_PICKED	5
#macro PACKET_MYID		6
#macro PACKET_NEW_BULLET	7

server = network_create_server(network_socket_tcp, PORT, MAX_CLIENTS)

buffer = buffer_create(16384, buffer_grow, 1)

clients = ds_map_create()
sockets = ds_list_create()
game_is_started = 0
enemies = ds_list_create()
bullets = ds_list_create()

boss = pointer_null

available_tanks = ds_list_create()
ds_list_add(available_tanks, TANK_CHARACTER_RED)
ds_list_add(available_tanks, TANK_CHARACTER_GREEN)
ds_list_add(available_tanks, TANK_CHARACTER_BLUE)
ds_list_add(available_tanks, TANK_CHARACTER_YELLOW)

