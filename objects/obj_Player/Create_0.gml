#macro KEY_LEFT		0
#macro KEY_RIGHT	1
#macro KEY_UP		2
#macro KEY_DOWN		3

keys[KEY_LEFT] = false
keys[KEY_RIGHT] = false
keys[KEY_UP] = false
keys[KEY_DOWN] = false

walkingSpeed = 2
horizontalSpeed = 0
verticalSpeed = 0

my_id = -1
name = "Player"
char = 0

if(instance_exists(obj_server)){
	visible = false //remove the sprite duplication on the player host
}

HandleSprites(char)

playerMaxhp = 100
playerhp =  playerMaxhp

//controller = 0

