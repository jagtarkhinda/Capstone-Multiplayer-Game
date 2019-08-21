cli_ene_col_time -= delta_time/1000000;

if(cli_ene_col_time < 1){
	with(other){
		playerhp -= 5
	}
	cli_ene_col_time = 2
}