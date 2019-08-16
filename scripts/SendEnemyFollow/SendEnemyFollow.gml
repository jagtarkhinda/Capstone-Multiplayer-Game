#macro ENE1F_X		0
#macro ENE1F_Y		1
#macro ENE1F_SPRITE	2
#macro ENE1F_DESTROY	3
#macro ENE1F_DIRECTION 4
#macro ENE1F_SPEED  5
#macro ENE1F_ANGLE 6


buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_ENEMYF_FOLLOW)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case ENE1F_X:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case ENE1F_Y:
		buffer_write(buffer, buffer_s16, argument3)
	break
	case ENE1F_DIRECTION:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1F_SPEED:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1F_ANGLE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1F_SPRITE:
		buffer_write(buffer, buffer_u16, argument3)
	break
	case ENE1F_DESTROY:
		buffer_write(buffer, buffer_u8, argument3)
	break
}

network_send_packet(argument0, buffer, buffer_tell(buffer))