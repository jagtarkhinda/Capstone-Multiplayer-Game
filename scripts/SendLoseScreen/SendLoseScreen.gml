#macro ALL_LOST		0

buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_ALLLOST)
buffer_write(buffer, buffer_u8, argument1) //second command
buffer_write(buffer, buffer_u32, argument2) //entity id

switch(argument1){
	case ALL_LOST:
		buffer_write(buffer, buffer_bool, argument3)
	break
	
}

network_send_packet(argument0, buffer, buffer_tell(buffer))