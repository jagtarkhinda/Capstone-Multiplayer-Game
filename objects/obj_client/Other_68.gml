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
	
///// ADDED - JSK
	//getting the enemy positions
	case PACKET_ENEMY1_POSITION :

		var c = buffer_read(buff, buffer_u8)
		var ene_id = buffer_read(buff, buffer_u32)
		
		if !ds_map_exists(enemies1, ene_id){
			var b = instance_create_layer(0, 0, "Enemy_Layer", obj_remote_entity)
			ds_map_set(enemies1, ene_id, b)
		}
		
		var en1 = enemies1[? ene_id]
		
		switch(c){
			case ENE1_X:
				en1.x = buffer_read(buff, buffer_s16)
			break
			case ENE1_Y:
				en1.y = buffer_read(buff, buffer_s16)
			break
			case ENE1_SPRITE:
				en1.sprite_index = buffer_read(buff, buffer_u16)
			break
			case ENE1_SPEED:
				en1.speed = buffer_read(buff, buffer_u16)
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
}
		
}