if(global.max_players == global.players_picked  || game_is_started > 0){
	//send data about other players
	for(var i = 0; i < instance_number(obj_Player); i++){
		var player = instance_find(obj_Player, i)
	
		for(var s = 0; s < ds_list_size(sockets); s++){
			var so = ds_list_find_value(sockets, s)
			SendRemoteEntity(so, CMD_X, player.id, player.x)
			SendRemoteEntity(so, CMD_Y, player.id, player.y)
			SendRemoteEntity(so, CMD_SPRITE, player.id, player.sprite_index)
			SendRemoteEntity(so, CMD_HP, player.id, player.playerhp)
		}
	}
	#region game_is_started == 1 //start some objects to the game
	if (!instance_exists(obj_boss) && game_is_started == 1){//game is starting
		//get all walls
		var num_walls = instance_number(obj_Wall)
		//show_debug_message("num_walls: " + string(num_walls));
		for(var s = 0; s < num_walls; s++){
			var w = instance_find(obj_Wall, s)
			ds_list_add(walls_list, w)
		}
		
		
		//CREATE WEAPONS
		randomize();
		var auxW = 0
		while(ds_list_size(weapons_list) < 4){
			rand_x = irandom(room_width);
			rand_y = irandom(room_height);
			if(place_free(rand_x, rand_y) && place_free(rand_x+32, rand_y) && place_free(rand_x-32, rand_y) && place_free(rand_x, rand_y+32) && place_free(rand_x, rand_y-32) && place_free(rand_x+32, rand_y+32) && place_free(rand_x-32, rand_y-32)){
				var wea = instance_create_layer(rand_x, rand_y, "Instances", obj_weapon)
				wea.weapon_type_id = auxW
				switch(auxW){
					case 0:
						wea.weapon_name = "Dual Bullet"
						wea.weapon_price = 250
					break
					case 1:
						wea.weapon_name = "HP regen"
						wea.weapon_price = 300
					break
					case 2:
						wea.weapon_name = "Missiles"
						wea.weapon_price = 400
					break
					case 3:
						wea.weapon_name = "Random five" 
						wea.weapon_price = 500
					break
				}
				auxW++
				ds_list_add(weapons_list, wea)
			}
		}
		
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
	}
	#endregion
	#region game_is_started == 2 // game loop
	else if(game_is_started == 2){
			game_timer -= delta_time/1000000; //every secound
			//boos shooting
			if(game_timer <= 0 && global.boss_rage)
			{
				game_timer = 30;
				if((boss.bossHp + 30) >= boss.bossMaxHp){
					boss.bossHp = boss.bossMaxHp 
				}else{
					boss.bossHp = 30
				}
				
				for(var en = 0; en < ds_list_size(enemies1); en++)
				{
					var enemy_i = ds_list_find_value(enemies1, en)
					if((enemy_i.monsterHp + 3) >= enemy_i.monsterMaxHp){
						enemy_i.monsterHp = enemy_i.monsterMaxHp 
					}else{
						enemy_i.monsterHp = 3
					}
				}
				
				//increase boss hp
				//increase enemy hp
			}
	
	
		//update weapons
		for(var i = 0; i < instance_number(obj_weapon); i++){
			var wea = instance_find(obj_weapon, i)
			for(var s = 0; s < ds_list_size(sockets); s++){
				var so = ds_list_find_value(sockets, s)
				SendWeaponDrop(so, W_X, wea.id, wea.x)
				SendWeaponDrop(so, W_Y, wea.id, wea.y)
				SendWeaponDrop(so, W_NAME, wea.id, wea.weapon_name)
				SendWeaponDrop(so, W_SPRITE, wea.id, wea.sprite_index)
				SendWeaponDrop(so, W_ID, wea.id, wea.weapon_type_id)
				SendWeaponDrop(so, W_PRICE, wea.id, wea.weapon_price)
			}
		}
	
		#region count_player_dead
		/*if player is dead count*/
		for(var i = 0; i < instance_number(obj_Player); i++)
		{
			var player = instance_find(obj_Player, i)
		
			if(player.playerhp <=0)
			{
				global.count_player_dead +=1
			}
			
		}
		if(global.count_player_dead == instance_number(obj_Player))
		{
			show_debug_message("All Players Dead Game Over");
			global.youlose = true
		
		}
		global.count_player_dead = 0;
			#endregion
	
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

		if(instance_exists(boss)) {
			if(global.boss_rage && global.current_level == 1 && boss.bossHp > 0)
			{
				boss_bullet_timer -= delta_time/1000000;
				//boos shooting
				if(boss_bullet_timer <= 0)
				{
					boss_bullet = instance_create_layer(boss.x,boss.y,"Enemy_Layer", obj_boss_bullet);
					boss_bullet_timer = 0.2;
					ds_list_add(boss_bullets_server,boss_bullet)
					#region respawn_more_enemies
				if(ds_list_size(enemies1) < 23 )
				{
					spawn_more = true;
				}
				if(spawn_more){
					for(var more_e = (ds_list_size(enemies1) - 1); more_e < 23 ; more_e++)
					{
						var more_ene = instance_create_layer(random_range(boss.x - 200, boss.x + 200),random_range(boss.y - 200, boss.y + 200),"Enemy_Layer",obj_enemy1);
						enemy_id += 1;
						ds_list_add(enemies1,more_ene)
						spawn_more = false
					}
				}
				#endregion
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
			}
		}
	#region boss Update
		for(var w = 0; w < ds_list_size(sockets); w++){
			var soc = ds_list_find_value(sockets, w)
			//update boss
			if(instance_exists(boss)){
				if(boss.bossHp <= 0){
					SendBossEntity(soc, BOSS_DESTROY, boss.id, 0)
					
					global.game_score += 150
					UpdateScore(soc, global.game_score)
					show_debug_message("Game Score: " + string(global.game_score))
					SendWinScreen(soc,true)
					for(var oo = 0; oo < ds_list_size(boss_bullets_server); oo++)
					{
						var bu = ds_list_find_value(boss_bullets_server, oo)
						SendBossBullet(soc, BB_DESTROY, bu.id,0)
					}
				}
				else {
					SendBossEntity(soc, BOSS_X, boss.id, boss.x)
					SendBossEntity(soc, BOSS_Y, boss.id, boss.y)
					SendBossEntity(soc, BOSS_NAME, boss.id, "Boss")
					SendBossEntity(soc, BOSS_SPRITE, boss.id, boss.sprite_index)
					SendBossEntity(soc, BOSS_HP, boss.id, boss.bossHp)
				}
			}
		}
	#endregion
	
		for(var s = 0; s < ds_list_size(sockets); s++){ //doesnt work properly, had to create new for loops for sockets/// see later
			var so = ds_list_find_value(sockets, s)
			//update boss
			/*SendBossEntity(so, BOSS_X, boss.id, boss.x)
			SendBossEntity(so, BOSS_Y, boss.id, boss.y)
			SendBossEntity(so, BOSS_NAME, boss.id, "Boss")
			SendBossEntity(so, BOSS_SPRITE, boss.id, boss.sprite_index)
		*/
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
						
						if(!enemy_i.enemy_moving){
							var random_x = irandom_range(0,enemy_i.x+100);
							var random_y = irandom_range(0,enemy_i.y+100);
							with(enemy_i){
								move_towards_point(random_x,random_y,2);
							
							}
							enemy_i.enemy_moving = true
						}
						
						
						
						
						/*var pos = irandom_range(1,20)
						var current_path = asset_get_index("path" + string(pos));
						//starting the path
						with(enemy_i){
							hasPath = true
							//path_start(current_path, 1, path_action_continue,true);
						
							path_start(current_path, 1, path_action_reverse,true);
						}
						*/
					}
				
				}
			}
		
			#region coin
			//Update the total money collected
			for(var w = 0; w < ds_list_size(sockets); w++){
				var soc = ds_list_find_value(sockets, w)
				UpdateMoney(soc, global.money)
			}
			#endregion
		
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
						global.game_score = 5
						UpdateScore(soc, global.game_score)
						show_debug_message("Game Score: " + string(global.game_score))
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
	#endregion game_is_started == 2 // game loop
	#region game_is_started == 3 // Win Situation
	else if(game_is_started == 3){
		//do something
	}
	#endregion game_is_started == 3 // Win Situation
	#region game_is_started == 3 // Loose Situation
	else if(game_is_started == 4){
		//do something
	}
	#endregion game_is_started == 3 // Loose Situation
	#region game_is_started == 5 // Restart prep
	else if(game_is_started == 5){
		//do something
	}
	#endregion game_is_started == 5 // Restart prep
}else{
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		SendWaitIsDone(so, global.wait_for_host)
	}
}
if(global.youlose)
{
	for(var i = 0; i < instance_number(obj_Player); i++){
		var player = instance_find(obj_Player, i)
		
		instance_create_layer(0,0,"End_Menu",obj_lose);
		
		for(var s = 0; s < ds_list_size(sockets); s++){
			var so = ds_list_find_value(sockets, s)
			SendLoseScreen(so,ALL_LOST,player.id,true)
			//SendRemoteEntity(so, CMD_PLAYER_HP, player.id, player.sprite_index)
		}
		
	}
}