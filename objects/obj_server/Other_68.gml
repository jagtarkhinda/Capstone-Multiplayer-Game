var event_id = async_load[? "id"]


if server == event_id{
	var type = async_load[? "type"]
	var sock = async_load[? "socket"]
	
	#region connect
	if(type == network_type_connect){
		//create a player, add the socket to teh list
		ds_list_add(sockets, sock)
		
		//create a player
		var playerH = instance_create_layer(64, 64+32, "Instances", obj_Player)
		//var playerH = instance_create_layer(64, 64+32*sock, "Instances", obj_Player)
		playerH.my_id = sock
		ds_map_add(clients, sock, playerH)
		
		ready[sock] = false
		//send data about other players
		for(var i = 0; i < instance_number(obj_Player); i++){
			var player = instance_find(obj_Player, i)
			SendRemoteEntity(sock, CMD_X, player.id, player.x)
			SendRemoteEntity(sock, CMD_Y, player.id, player.y)
			SendRemoteEntity(sock, CMD_NAME, player.id, player.name)
			SendRemoteEntity(sock, CMD_SPRITE, player.id, player.sprite_index)
			SendRemoteEntity(sock, CMD_MYID, player.id, player.my_id)
		}
		
		for(var c = 0; c <= TANK_CHARACTER_YELLOW; c++){
			var a = false
			if (ds_list_find_value(available_tanks, ds_list_find_index(available_tanks, c)) != undefined){
				a = true
			}
			
			if(game_is_started == 0){
				game_is_started = 1
			}
			SendPicked(sock, c, a)
		}
	}
	
	#endregion disconnect
	#region disconnect
	if(type == network_type_disconnect){
		p = clients[? sock]
		
		//destroy the client that left
		for(var s = 0; s < ds_list_size(sockets); s++){
			var so = ds_list_find_value(sockets, s)
			SendRemoteEntity(so, CMD_DESTROY, p.id, 0)
		}
		
		if(instance_exists(p)){
			with(p){
				instance_destroy()
			}
		}
		
		ds_list_delete(sockets, ds_list_find_index(sockets, sock))
		ds_map_delete(clients, sock)
	}
	#endregion disconnect
	
}else if event_id != global.socket{
	var sock = async_load[? "id"]
	var buff = async_load[? "buffer"]
	buffer_seek(buff, buffer_seek_start, 0)
	var cmd = buffer_read(buff, buffer_u8)
	
	var p = clients[? sock]
	switch (cmd){
		case PACKET_KEY :
			with(p){
				var k = buffer_read(buff, buffer_u8)
				var s = buffer_read(buff, buffer_u8)
				keys[k] = s
			}
		break
		case PACKET_NAME :
			p.name = buffer_read(buff, buffer_string)
			for(var s = 0; s < ds_list_size(sockets); s++){
				var so = ds_list_find_value(sockets, s)
				SendRemoteEntity(so, CMD_NAME, p.id, p.name)
			}
		break
		case PACKET_TANK_CHARACTER :
			
			if ready[sock] = false{
				var c = buffer_read(buff, buffer_u8)
				if ds_list_find_value(available_tanks, ds_list_find_index(available_tanks, c)) != undefined{
					p.character = c
					ready[sock] = true
					//let the client play
					SendPlay(sock)
					with(p){
						HandleSprites(c)
						
					}
					for(var s = 0; s < ds_list_size(sockets); s++){
						var so = ds_list_find_value(sockets, s)
						SendPicked(so, c, true)
					}
					ds_list_delete(available_tanks, ds_list_find_index(available_tanks, c))	
				}
				
				//if the player has selected the tank , we will update the enemies sprites -jsk
				//instance_create_layer(0,0,"Instances",enemy1_spawn);
				//adding all the enemies to ds_lis

				if(ds_list_size(enemies1) < 17 && enemies_done == 0){
					var missing_enemies = 17 - ds_list_size(enemies1)
					for(var s = 0; s < missing_enemies; s++){
						//incrementing the id everytime a new enemy spawn
						ene = instance_create_layer(762,1211,"Enemy_Layer",obj_enemy1);
						enemy_id += 1;
						//making each enemy follow some path
						//setting up different path for each instance according to the current id
						var current_path = asset_get_index("path" + string(enemy_id));
						//starting the path
						with(ene){
			
						path_start(current_path, 1, path_action_reverse, true);
						hasPath = true
						}
						ds_list_add(enemies1, ene)
					}
					enemies_done = 1
				}
				
				
			}
		break
		
		case PACKET_MYID :
			SendPlayerID(sock, sock)
		break
		
		case PACKET_NEW_BULLET :
			#region PACKET_NEW_BULLET
			mouse_xpos = buffer_read(buff, buffer_s16)
			mouse_ypos = buffer_read(buff, buffer_s16)

			b = instance_create_layer(p.x, p.y, "Bullet_Layer", obj_Bullet)
			b.direction = point_direction(p.x, p.y, mouse_xpos, mouse_ypos);
			b.direction = b.direction + random_range(1,1);
			b.speed = 10;
			b.image_angle = b.direction;
				
			ds_map_add(bullets, sock, b)
				
			//update bullet to clients
			for(var s = 0; s < ds_list_size(sockets); s++){
				var so = ds_list_find_value(sockets, s)
				SendBullet(so, BULL_X, b.id, b.x)
				SendBullet(so, BULL_Y, b.id, b.y)
				SendBullet(so, BULL_DIRECTION, b.id, b.direction)
				SendBullet(so, BULL_SPEED,b.id,b.speed)
				SendBullet(so, BULL_ANGLE,b.id,b.image_angle)	
				SendBullet(so, BULL_SPRITE, b.id, b.sprite_index)
			}
			#endregion PACKET_NEW_BULLET
		break
		
		case PACKET_ENEMY1_DESTROIED :
			#region PACKET_ENEMY1_DESTROIED
			/*var en_id = buffer_read(buff, buffer_s16)
			var en_x = buffer_read(buff, buffer_s16)
			var en_y = buffer_read(buff, buffer_s16)
		
			for(var en = 0; en < ds_list_size(enemies1); en++){
				var enemy = ds_list_find_value(enemies1, en)
				with(enemy){
					show_debug_message("create coin")
					SendEnemyPositions(so, ENE1_DESTROY, enemy.id, 0)
					instance_destroy()
				}
			}*/
			#endregion PACKET_ENEMY1_DESTROIED
		break

	}
	
}