if(global.max_players == global.players_picked){

	//send data about other players
	for(var i = 0; i < instance_number(obj_Player); i++){
		var player = instance_find(obj_Player, i)
	
		for(var s = 0; s < ds_list_size(sockets); s++){
			var so = ds_list_find_value(sockets, s)
			SendRemoteEntity(so, CMD_X, player.id, player.x)
			SendRemoteEntity(so, CMD_Y, player.id, player.y)
			SendRemoteEntity(so, CMD_SPRITE, player.id, player.sprite_index)
			//SendRemoteEntity(so, CMD_PLAYER_HP, player.id, player.sprite_index)
		}
	}

	if (!instance_exists(obj_boss) && game_is_started == 1){//game is starting
		//get all walls
		var num_walls = instance_number(obj_Wall)
		//show_debug_message("num_walls: " + string(num_walls));
		for(var s = 0; s < num_walls; s++){
			var w = instance_find(obj_Wall, s)
			ds_list_add(walls_list, w)
		}
		
		randomize();
		//CREATE WEAPONS
		var auxW = 0
		//var rand_x = 0
		//var rand_y = 0
		while(ds_list_size(weapons_list) < 4){
			//rand_x = random_range(0,room_width);
			//rand_y = random_range(0,room_height);
			rand_x = irandom(room_width);
			rand_y = irandom(room_height);
			show_debug_message("Coords:" + string(rand_x) + " - "+ string(rand_y))
			if(place_free(rand_x, rand_y) 
			&& place_free(rand_x+32, rand_y) 
			&& place_free(rand_x-32, rand_y) 
			&& place_free(rand_x, rand_y+32) 
			&& place_free(rand_x, rand_y-32) 
			&& place_free(rand_x+32, rand_y+32)
			&& place_free(rand_x-32, rand_y-32)){
				var wea = instance_create_layer(rand_x, rand_y, "Instances", obj_weapon)
				show_debug_message("Coords - IN:" + string(rand_x) + " - "+ string(rand_y))
				wea.weapon_obj_id = auxW
				auxW++
				ds_list_add(weapons_list, wea)
			}
		}
		
		show_debug_message("weapons_list:" + string(ds_list_size(weapons_list)))
		
			
	
		//create boss
		boss = instance_create_layer(room_width/2, room_height/2, "Enemy_Layer", obj_boss)
		for(var s = 0; s < ds_list_size(sockets); s++){
			var so = ds_list_find_value(sockets, s)
			SendBossEntity(so, BOSS_X, boss.id, boss.x)
			SendBossEntity(so, BOSS_Y, boss.id, boss.y)
			SendBossEntity(so, BOSS_NAME, boss.id, "Boss")
			SendBossEntity(so, BOSS_SPRITE, boss.id, boss.sprite_index)
		
		}
		game_is_started = 2
		global.current_level = 1;
	}else if(game_is_started == 2){
	
		//send hp about other players
		for(var i = 0; i < instance_number(obj_Player); i++)
		{
			var player = instance_find(obj_Player, i)
			for(var s = 0; s < ds_list_size(sockets); s++)
			{
				var so = ds_list_find_value(sockets, s)
				if(player.playerhp <=  0)
				{
					SendRemoteEntity(so,CMD_HP,player.id,player.playerhp)
					SendRemoteEntity(so,CMD_DISABLE,player.id,0)
				}
				else{
					SendRemoteEntity(so,CMD_HP,player.id,player.playerhp)
					//show_debug_message("Player hp now " + string(player.playerhp))
				}
			}
		}

		if(global.boss_rage && global.current_level == 1)
		{
			boss_bullet_timer -= delta_time/1000000;
			//boos shooting
			if(boss_bullet_timer <= 0)
			{
				boss_bullet = instance_create_layer(boss.x,boss.y,"Enemy_Layer", obj_boss_bullet);
				boss_bullet_timer = 0.2;
				ds_list_add(boss_bullets_server,boss_bullet)
			}
		
		
			
				//update bullets everywhere
				for(var oo = 0; oo < ds_list_size(boss_bullets_server); oo++)
					{
						var bu = ds_list_find_value(boss_bullets_server, oo)
					//	var ww = instance_find(obj_boss_bullet, bu)
						if(bu.bb_hp <= 0)
						{
							ds_list_delete(boss_bullets_server, oo)
							for(var w = 0; w < ds_list_size(sockets); w++)
							{
									var soc = ds_list_find_value(sockets, w)
									//send to destroy client side enemy
									SendBossBullet(soc, BB_DESTROY, bu.id,0)
							}
						
							with(bu){
								instance_destroy()
							}
						}
							else if(instance_exists(bu))
							{
								for(var s = 0; s < ds_list_size(sockets); s++)
								{
									var so = ds_list_find_value(sockets, s)
									SendBossBullet(so, BB_X, bu.id, bu.x)
									SendBossBullet(so, BB_Y, bu.id, bu.y)
									SendBossBullet(so, BB_NAME, bu.id, "Bullet")
									SendBossBullet(so, BB_SPRITE, bu.id, bu.sprite_index)
								}
							}
					
				}
			
		
			show_debug_message("boss rage");
		
		}
	
	
		for(var s = 0; s < ds_list_size(sockets); s++){ //doesnt work properly, had to create new for loops for sockets/// see later
			var so = ds_list_find_value(sockets, s)
			//update boss
			SendBossEntity(so, BOSS_X, boss.id, boss.x)
			SendBossEntity(so, BOSS_Y, boss.id, boss.y)
			SendBossEntity(so, BOSS_NAME, boss.id, "Boss")
			SendBossEntity(so, BOSS_SPRITE, boss.id, boss.sprite_index)
		
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
						SendBullet(so, BULL_DIRECTION, bu.id, bu.direction)
						SendBullet(so, BULL_SPEED,bu.id,bu.speed)
						SendBullet(so, BULL_ANGLE,bu.id,bu.image_angle)
						SendBullet(so, BULL_SPRITE, bu.id, bu.sprite_index)
					}
			}

			//looping all enemies
			for(var en = 0; en < ds_list_size(enemies1); en++)
			{
				var player_closer = noone //near player from enemy perspective
				var distance = 200 // max distance
				var enemy_i = ds_list_find_value(enemies1, en)
					
				for(var follow_player = 0; follow_player < ds_list_size(sockets); follow_player++)
				{
					//select the closes player 
					var p = ds_list_find_value(sockets, follow_player)
					var f_p = clients[? p]
				
					if(f_p.sprite_index != spr_boss){//change later
						with(enemy_i)
						{
							if (distance_to_object(f_p) < distance) //checks the current min distance
							{
								player_closer = f_p
								distance = distance_to_object(f_p)
							}
						}
					}
				}
				//takes the closes player and make the enemy follow him
				if(player_closer != noone){
					with(enemy_i)
					{
						hasPath = false
						path_end();
						move_towards_point(player_closer.x, player_closer.y, 1);
					}
				}else{
					if(!enemy_i.hasPath){
						var pos = irandom_range(1,20)
						var current_path = asset_get_index("path" + string(pos));
						//starting the path
						with(enemy_i){
							hasPath = true
							//path_start(current_path, 1, path_action_continue,true);
						
							path_start(current_path, 1, path_action_reverse,true);
						}
					}
				
				}
			}
		
			//Update the total money collected
			for(var w = 0; w < ds_list_size(sockets); w++){
				var soc = ds_list_find_value(sockets, w)
				UpdateMoney(soc, global.money)
			}
		
			//update enemies
			for(var en = 0; en < ds_list_size(enemies1); en++){
				var enemy = ds_list_find_value(enemies1, en)
				if(enemy.monsterHp <= 0){
					ds_list_delete(enemies1, en)
					var nCoin = instance_create_layer(enemy.x, enemy.y, "Coin_Layer", obj_coin)

					for(var w = 0; w < ds_list_size(sockets); w++){
						var soc = ds_list_find_value(sockets, w)
						//send to destroy client side enemy
						SendEnemyPositions(soc, ENE1_HP, enemy.id, enemy.monsterHp)
						SendEnemyPositions(soc, ENE1_DESTROY, enemy.id, 0)
					
						//send to create a coin in client side
						SendNewCoin(soc, COIN_X, nCoin.id, nCoin.x)
						SendNewCoin(soc, COIN_Y, nCoin.id, nCoin.y)
						SendNewCoin(soc, COIN_SPRITE, nCoin.id, nCoin.sprite_index)
					}
					with(enemy){
						//try to stop the enemy // see later
						instance_destroy()
						path_speed = 0
						path_end()
					}
				}else{
					if(instance_exists(enemy)){
						for(var w = 0; w < ds_list_size(sockets); w++){
							var soc = ds_list_find_value(sockets, w)
							SendEnemyPositions(soc, ENE1_X, enemy.id, enemy.x)
							SendEnemyPositions(soc, ENE1_SPEED,enemy.id,2)
							SendEnemyPositions(soc, ENE1_Y, enemy.id, enemy.y)
							SendEnemyPositions(soc, ENE1_HP, enemy.id, enemy.monsterHp)
							SendEnemyPositions(soc, ENE1_SPRITE, enemy.id, enemy.sprite_index)
						}
					}
				}
			}
		}
	}
}else{
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		SendWaitIsDone(so, global.wait_for_host)
	}
}