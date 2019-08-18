buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_UPDATE_MONEY)
buffer_write(buffer, buffer_s16, argument1) //second command
network_send_packet(argument0, buffer, buffer_tell(buffer))