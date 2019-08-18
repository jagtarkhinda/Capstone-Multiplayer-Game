#macro COIN_X		0
#macro COIN_Y		1
#macro COIN_SPRITE	2
#macro COIN_DESTROY	3

buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_COIN)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case COIN_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case COIN_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case COIN_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case COIN_DESTROY:
		buffer_write(buffer, buffer_u16, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))