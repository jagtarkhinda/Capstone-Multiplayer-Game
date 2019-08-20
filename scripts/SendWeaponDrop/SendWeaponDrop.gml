#macro W_X			0
#macro W_Y			1
#macro W_NAME		2
#macro W_SPRITE		3
#macro W_ID			4
#macro W_DESTROY	5
#macro W_PRICE		6

buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_WEAPON_BOX)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case W_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case W_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case W_NAME:
		buffer_write(buffer, buffer_string, argument3)
	break
	case W_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case W_DESTROY:
		buffer_write(buffer, buffer_u8, argument3)
	break
	case W_ID:
		buffer_write(buffer, buffer_u8, argument3)
	break
	case W_PRICE:
		buffer_write(buffer, buffer_s16, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))