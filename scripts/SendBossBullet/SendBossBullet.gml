#macro BB_X		0
#macro BB_Y		1
#macro BB_NAME		2
#macro BB_SPRITE	3
#macro BB_DESTROY	4
#macro BB_MYID		5

buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_BOSS_BULLET)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case BB_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case BB_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case BB_NAME:
		buffer_write(buffer, buffer_string, argument3)
	break
	case BB_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case BB_DESTROY:
		buffer_write(buffer, buffer_u8, argument3)
	break
	case BB_MYID:
		buffer_write(buffer, buffer_u8, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))