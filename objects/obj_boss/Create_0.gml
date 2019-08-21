/// @description Insert description here
// You can write your code in this editor
left = true;
right = false;

bossMaxHp = 10
bossHp = bossMaxHp
ser_boss_col_time = 2

boss_moving = false

if(instance_exists(obj_server)){
	visible = false //remove the sprite duplication on the player host
}
