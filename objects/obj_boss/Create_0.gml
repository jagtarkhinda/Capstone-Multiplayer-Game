/// @description Insert description here
// You can write your code in this editor
random_time = 0;
next_spawn = 0;
enemy_count = 0;
left = true;
right = false;

//variable to keep track of enemy count
total_enemies = 0;

if(instance_exists(obj_server)){
	visible = false //remove the sprite duplication on the player host
}
