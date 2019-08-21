//init server
#macro PORT		5646
#macro MAX_CLIENTS	4

//tanks to select
#macro TANK_CHARACTER_RED		0
#macro TANK_CHARACTER_GREEN		1
#macro TANK_CHARACTER_BLUE		2
#macro TANK_CHARACTER_YELLOW	3

//weapons
#macro WEAPON_DUAL_BULLET		0
#macro WEAPON_HP_REGEN			1
#macro WEAPON_MISSILE			2
#macro WEAPON_RANDOM_FIVE		3

//packets
#macro PACKET_KEY				0
#macro PACKET_ENTITY			1
#macro PACKET_NAME				2
#macro PACKET_TANK_CHARACTER	3
#macro PACKET_PLAY				4
#macro PACKET_PICKED			5
#macro PACKET_MYID				6
#macro PACKET_NEW_BULLET		7
#macro PACKET_ENEMY1_POSITION	8
#macro PACKET_ENEMYF_FOLLOW		9
#macro PACKET_BULLET_WALL		10
#macro PACKET_BULLET_WALL2		11
#macro PACKET_ENEMY1_DESTROIED	12
#macro PACKET_COIN				13
#macro PACKET_UPDATE_MONEY		14
#macro PACKET_BOSS_ENTITY		15
#macro PACKET_BOSS_BULLET		16
#macro PACKET_WAIT_DONE			17
#macro PACKET_WEAPON_BOX		18
#macro PACKET_REQUEST_WEAPON	19
#macro PACKET_SPECIAL_ABILITY	20
#macro PACKET_UPDATE_SCORE	21
#macro PACKET_BOSS_BULLET_HIT    31
#macro PACKET_ALLLOST			32
var invalid_number = true
while(invalid_number){
	global.max_players = get_string("Enter a valid number of max players", "")
	
	if(global.max_players == "1" || global.max_players == "2" || global.max_players == "3" || global.max_players == "4"){
		invalid_number = false
	}
}
global.players_picked = 0

#region var_all_player_dead:
	global.count_player_dead = 0
#endregion



server = network_create_server(network_socket_tcp, PORT, MAX_CLIENTS)

buffer = buffer_create(16384, buffer_grow, 1)

clients = ds_map_create()
sockets = ds_list_create()

game_is_started = 0

boss_bullet_timer = 0.2
game_timer = 30
//list of walls
walls_list = ds_list_create()

//weapons list
weapons_list = ds_list_create()

//to store enemies
enemies1 = ds_list_create()

bullets = ds_list_create()
boss_bullets_server = ds_list_create()
enemy_id = 0;
boss = noone
global.money = 0
global.game_score = 0
global.boss_rage = false
global.current_level = 0;
global.youlose = false;
enemies_done = 0


available_tanks = ds_list_create()
ds_list_add(available_tanks, TANK_CHARACTER_RED)
ds_list_add(available_tanks, TANK_CHARACTER_GREEN)
ds_list_add(available_tanks, TANK_CHARACTER_BLUE)
ds_list_add(available_tanks, TANK_CHARACTER_YELLOW)

