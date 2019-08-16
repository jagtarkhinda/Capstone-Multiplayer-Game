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
	/*if(ds_list_size(enemies) < 5){
		var missing_enemies = 5 - ds_list_size(enemies)
		for(var s = 0; s < missing_enemies; s++){
			ene = instance_create_layer(room_width/2, room_width/2, "Enemy_Layer", obj_child)
			ds_list_add(enemies, ene)
		}
	}*/
	
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		//update boss
		SendRemoteEntity(so, CMD_X, boss.id, boss.x)
		SendRemoteEntity(so, CMD_Y, boss.id, boss.y)
		SendRemoteEntity(so, CMD_NAME, boss.id, "Boss")
		SendRemoteEntity(so, CMD_SPRITE, boss.id, boss.sprite_index)
	
		//update enemies
		//ADDED - JSK
		for(var en = 0; en < ds_list_size(enemies1); en++){
			var enemy = ds_list_find_value(enemies1, en)
			SendEnemyPositions(so, ENE1_X, enemy.id, enemy.x)
			SendEnemyPositions(so,ENE1_SPEED,enemy.id,2)
			SendEnemyPositions(so, ENE1_Y, enemy.id, enemy.y)
		//	SendEnemyPositions(so, ENE1_NAME, enemy.id, "Enemy")
			SendEnemyPositions(so, ENE1_SPRITE, enemy.id, enemy.sprite_index)
		}
		
		#region
			//if()
		#endregion
		
		
		//send data about other players
for(var i = 0; i < instance_number(obj_Player); i++){
	var playera = instance_find(obj_Player, i)
	
		//update bullet to clients
		for(var oo = 0; oo < ds_list_size(bullets); oo++){
			var bu = ds_list_find_value(bullets, oo)
			bu.direction = point_direction(playera.x,playera.y, mouse_xpos, mouse_ypos);
			bu.direction = bu.direction + random_range(1,1);
			bu.speed = 10;
			bu.image_angle = b.direction;
			SendBullet(so, BULL_X, bu.id, bu.x)
			SendBullet(so, BULL_Y, bu.id, bu.y)
			//sending the speed,angle and direction of bullet - jsk
			SendBullet(so, BULL_DIRECTION, bu.id, bu.direction)
			SendBullet(so, BULL_SPEED,bu.id,bu.speed)
			SendBullet(so, BULL_ANGLE,bu.id,bu.image_angle)
			//
			SendBullet(so, BULL_SPRITE, bu.id, bu.sprite_index)
		}
}
			
			//making enemies follow the player -JSK
				for(var en = 0; en < ds_list_size(enemies1); en++)
						{
							var enemy_i = ds_list_find_value(enemies1, en)
							
							for(var follow_player = 0; follow_player < ds_list_size(sockets); follow_player++)
							{
								var f_p = ds_list_find_value(sockets, follow_player)
								if(distance_to_object(f_p) < 200)
								{
									
								}
							}
								with(enemy_i)
								{
									if (distance_to_object(f_p) < 200)
									{
										path_end();
										move_towards_point(f_p.x,f_p.y,1);
								
									}
								}
					}
				}
			
		
	}
}