#macro BULL_X		0
#macro BULL_Y		1
#macro BULL_SPRITE	2
#macro BULL_DESTROY	3
#macro BULL_DIRECTION 4
#macro BULL_SPEED  5
#macro BULL_ANGLE 6


buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_NEW_BULLET)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case BULL_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case BULL_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case BULL_DIRECTION:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case BULL_SPEED:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case BULL_ANGLE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case BULL_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case BULL_DESTROY:
		buffer_write(buffer, buffer_u8, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))