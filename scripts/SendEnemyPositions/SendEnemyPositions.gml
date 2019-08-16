#macro ENE1_X		0
#macro ENE1_Y		1
#macro ENE1_SPRITE	2
#macro ENE1_DESTROY	3
#macro ENE1_DIRECTION 4
#macro ENE1_SPEED  5
#macro ENE1_ANGLE 6


buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_ENEMY1_POSITION)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case ENE1_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case ENE1_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case ENE1_DIRECTION:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1_SPEED:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1_ANGLE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1_DESTROY:
		buffer_write(buffer, buffer_u8, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))