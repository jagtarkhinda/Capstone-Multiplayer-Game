/// @description Insert description here
// You can write your code in this editor

//variable to keep track of each enemy instance
enemy_id = 1;

for(i = 1; i<= 17 ; i++)
{
	//incrementing the id everytime a new enemy spawn
	
		instance_create_layer(762,1211,"Enemy_Layer",obj_enemy1);
		enemy_id += 1;
}

