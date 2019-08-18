var event_id = async_load[? "id"]

if socket == event_id{
	var buff = async_load[? "buffer"]
	buffer_seek(buff, buffer_seek_start, 0)
	var cmd = buffer_read(buff, buffer_u8)
	
	switch(cmd){
	case PACKET_ENTITY:
		var c = buffer_read(buff, buffer_u8)
		var e_id = buffer_read(buff, buffer_u32)
		
		if !ds_map_exists(entities, e_id){
			var p = instance_create_layer(0, 0, "Instances", obj_remote_entity)
			ds_map_set(entities, e_id, p)
		}
		
		var p = entities[? e_id]
		
		switch(c){
			case CMD_X:
				p.x = buffer_read(buff, buffer_s16)
			break
			case CMD_Y:
				p.y = buffer_read(buff, buffer_s16)
			break
			case CMD_NAME:
				p.name = buffer_read(buff, buffer_string)
			break
			case CMD_SPRITE:
				p.sprite_index = buffer_read(buff, buffer_u16)
			break
			case CMD_DESTROY:
				buffer_read(buff, buffer_u8)
				ds_map_delete(entities, e_id)
				with(p){
					instance_destroy()
				}
				
			break
			case CMD_MYID:
				p.my_id = buffer_read(buff, buffer_u8)
			break
		}
	break
	case PACKET_PLAY :
		playing = true
	break
	case PACKET_PICKED :
		picked[buffer_read(buff, buffer_u8)] = buffer_read(buff, buffer_u8)
	break
	case PACKET_MYID :
		my_id = buffer_read(buff, buffer_u8)
	break
	//getting data about bullet
	case PACKET_NEW_BULLET :
		var c = buffer_read(buff, buffer_u8)
		var b_id = buffer_read(buff, buffer_u32)
		if !ds_map_exists(bullets, b_id){
			var b = instance_create_layer(0, 0, "Bullet_Layer", obj_remote_bullet)
			ds_map_set(bullets, b_id, b)
		}
		
		var b = bullets[? b_id]
		switch(c){
			case BULL_X:
				b.x = buffer_read(buff, buffer_s16)
			break
			case BULL_Y:
				b.y = buffer_read(buff, buffer_s16)
			break
			case BULL_SPRITE:
				b.sprite_index = buffer_read(buff, buffer_u16)
			break
			case BULL_DIRECTION:
				b.direction = buffer_read(buff, buffer_u16)
			break
			case BULL_ANGLE:
				b.image_angle = buffer_read(buff, buffer_u16)
			break
			case BULL_SPEED:
				b.speed = buffer_read(buff, buffer_u16)
			break
			case BULL_DESTROY:
				buffer_read(buff, buffer_u8)
				ds_map_delete(bullets, b_id)
				with(b){
					instance_destroy()
				}
			break
		}
	break
	
	//getting the enemy positions
	case PACKET_ENEMY1_POSITION :

		var c = buffer_read(buff, buffer_u8)
		var ene_id = buffer_read(buff, buffer_u32)
		
		if !ds_map_exists(enemies1, ene_id){
			var t = instance_create_layer(0, 0, "Enemy_Layer", obj_remote_enemy)
			t.enemy_Uid = ene_id
			ds_map_set(enemies1, ene_id, t)
		}
		
		var enemy = enemies1[? ene_id]
		
		
		switch(c){
			case ENE1_X:
				enemy.x = buffer_read(buff, buffer_s16)
			break
			case ENE1_Y:
				enemy.y = buffer_read(buff, buffer_s16)
			break
			case ENE1_SPRITE:
				enemy.sprite_index = buffer_read(buff, buffer_u16)
			break
			case ENE1_SPEED:
				enemy.speed = buffer_read(buff, buffer_u16)
			break
			case ENE1_DESTROY:
				buffer_read(buff, buffer_u16)
				show_debug_message("CLIENT 1 - Shooted monster id: " + string(ene_id))
				show_debug_message("CLIENT 1 - Shooted monster Hp: " + string(enemy.monsterHp))
				//with(instance_find(obj_remote_enemy, ene_id)){
				
				show_debug_message("CLIENT 1 - enemies1 size: " + string(ds_map_size(enemies1)))
				var num_en = instance_number(obj_remote_enemy)
				show_debug_message("CLIENT 1 - num_en: " + string(num_en));
				ds_map_delete(enemies1, ene_id)
				
				enemy.visible = false
				instance_destroy(enemy.id);
				/*with(enemy){
					show_debug_message("CLIENT 2 - Shooted monster id: " + string(id))
					show_debug_message("CLIENT 2 - Shooted monster enemy_Uid: " + string(enemy_Uid))
					show_debug_message("CLIENT 2 - Shooted monster Hp: " + string(monsterHp))
					instance_destroy()
				}*/
				show_debug_message("CLIENT 2 - enemies1 size: " + string(ds_map_size(enemies1)))
				num_en = instance_number(obj_remote_enemy)
				show_debug_message("CLIENT 2 - num_en: " + string(num_en));
			
			break
			case ENE1_HP:
				enemy.monsterHp = buffer_read(buff, buffer_s16)
			break
		}
	break
	
	case PACKET_COIN:
		show_debug_message("CLIENT coin ");
		var c = buffer_read(buff, buffer_u8)
		var coin_id = buffer_read(buff, buffer_u32)
		
		if !ds_map_exists(coin_map, coin_id){
			var t = instance_create_layer(0, 0, "Coin_Layer", obj_remote_coin)
			t.coin_Uid = coin_id
			ds_map_set(coin_map, coin_id, t)
		}
		var coin = coin_map[? coin_id]
		
		show_debug_message("CLIENT - coin.id: " + string(coin.id));
		show_debug_message("CLIENT - coin.UId: " + string(coin.coin_Uid));
		switch(c){
			case COIN_X:
				coin.x = buffer_read(buff, buffer_s16)
			break
			case COIN_Y:
				coin.y = buffer_read(buff, buffer_s16)
			break
			case COIN_SPRITE:
				coin.sprite_index = buffer_read(buff, buffer_u16)
			break
			case COIN_DESTROY:
				buffer_read(buff, buffer_u16)

				//var num_en = instance_number(obj_remote_enemy)
				ds_map_delete(coin_map, coin_id)
				
				coin.visible = false
				instance_destroy(coin.id);
			break
		}
	break
}
		
}