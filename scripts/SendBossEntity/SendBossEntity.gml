#macro BOSS_X		0
#macro BOSS_Y		1
#macro BOSS_NAME		2
#macro BOSS_SPRITE	3
#macro BOSS_DESTROY	4
#macro BOSS_MYID		5

buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_BOSS_ENTITY)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case BOSS_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case BOSS_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case BOSS_NAME:
		buffer_write(buffer, buffer_string, argument3)
	break
	case BOSS_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case BOSS_DESTROY:
		buffer_write(buffer, buffer_u8, argument3)
	break
	case BOSS_MYID:
		buffer_write(buffer, buffer_u8, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))