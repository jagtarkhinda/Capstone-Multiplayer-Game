cli_boss_col_time -= delta_time/1000000

if(cli_boss_col_time < 1){
	with(other){
		playerhp -= 20;
	}
	cli_boss_col_time = 2
}
