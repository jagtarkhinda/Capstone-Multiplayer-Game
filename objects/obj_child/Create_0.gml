/*
sprite_index = -1;
range = 200;
bullet_delay = 0;
//	health points
mask_index = -1;
spd = 2;
obj_flag = true;
obj_id = obj_boss.enemy_count;
*/
maxHp = 5;
hp = maxHp;

if(instance_exists(obj_server)){
	visible = false //remove the sprite duplication on the player host
}