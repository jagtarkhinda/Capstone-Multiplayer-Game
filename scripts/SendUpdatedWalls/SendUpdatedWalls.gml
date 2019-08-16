#macro WALL_HP			0
#macro WALL_SPRITE		1
#macro WALL_DESTROY		2


buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_BULLET_WALL)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case WALL_HP:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case WALL_SPRITE:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case WALL_DESTROY:
		buffer_write(buffer, buffer_s16, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))