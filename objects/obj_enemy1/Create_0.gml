
//stopping the animation
//image_speed = 0;

//enemy variables
//speed
enemy1_speed = 1.5;

//assigning each created enemy a new id
//enemy1_id = enemy1_spawn.enemy_id;

//setting up different path for each instance according to the current id
//current_path = asset_get_index("path" + string(enemy1_id));
//starting the path
//path_start(current_path, enemy1_speed, path_action_reverse,true);

if(instance_exists(obj_server)){
	visible = false //remove the sprite duplication on the player host
}

monsterMaxHp = 100
monsterHp = monsterMaxHp
hasPath = false
enemy_moving = false
