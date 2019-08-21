buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET_UPDATE_SCORE)
buffer_write(buffer, buffer_s32, argument1) //second command
network_send_packet(argument0, buffer, buffer_tell(buffer))