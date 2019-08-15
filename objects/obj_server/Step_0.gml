//send data about other players
for(var i = 0; i < instance_number(obj_Player); i++){
	var player = instance_find(obj_Player, i)
	
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		SendRemoteEntity(so, CMD_X, player.id, player.x)
		SendRemoteEntity(so, CMD_Y, player.id, player.y)
		SendRemoteEntity(so, CMD_SPRITE, player.id, player.sprite_index)
	}
}

if (!instance_exists(obj_boss) && game_is_started == 1){//game is starting
	//create boss
	boss = instance_create_layer(room_width/2, room_width/2, "Enemy_Layer", obj_boss)
	
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		SendRemoteEntity(so, CMD_X, boss.id, boss.x)
		SendRemoteEntity(so, CMD_Y, boss.id, boss.y)
		SendRemoteEntity(so, CMD_NAME, boss.id, "Boss")
		SendRemoteEntity(so, CMD_SPRITE, boss.id, boss.sprite_index)
	}
	
	game_is_started = 2
}else if(game_is_started == 2){ //game steps
	// make the enemy move
	if(boss.left == true)
	{
		boss.x = boss.x-2;
		boss.y = boss.y-1;
	}
	else if (boss.right == true)
	{
		boss.x = boss.x+2;
		boss.y = boss.y+1;
	}

	if(boss.x <= 200)
	{
		boss.right = true;
		boss.left = false;
	}
	else if(boss.x >= 500)
	{
		boss.left = true;
		boss.right = false;
	}
	
	//create enemies to a total of 5
	if(ds_list_size(enemies) < 5){
		var missing_enemies = 5 - ds_list_size(enemies)
		for(var s = 0; s < missing_enemies; s++){
			ene = instance_create_layer(room_width/2, room_width/2, "Enemy_Layer", obj_child)
			ds_list_add(enemies, ene)
		}
	}
	
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		//update boss
		SendRemoteEntity(so, CMD_X, boss.id, boss.x)
		SendRemoteEntity(so, CMD_Y, boss.id, boss.y)
		SendRemoteEntity(so, CMD_NAME, boss.id, "Boss")
		SendRemoteEntity(so, CMD_SPRITE, boss.id, boss.sprite_index)
		//show_debug_message("boss.sprite_index: " + string(boss.sprite_index));
		
		//show_debug_message("Enemies: " + string(ds_list_size(enemies)));
		//update enemies
		for(var en = 0; en < ds_list_size(enemies); en++){
			var enemy = ds_list_find_value(enemies, en)
			SendRemoteEntity(so, CMD_X, enemy.id, enemy.x)
			SendRemoteEntity(so, CMD_Y, enemy.id, enemy.y)
			SendRemoteEntity(so, CMD_NAME, enemy.id, "Enemy")
			SendRemoteEntity(so, CMD_SPRITE, enemy.id, enemy.sprite_index)
		}
	}
}