module middle #(parameter WIDTH = 32)(clk_i, rst_i, 
				valid_in_i,ready_in_o,data_in_i, 
				valid_out_o, data_out_o, ready_out_i);

input wire clk_i,rst_i;
input wire valid_in_i,ready_out_i;
input reg[WIDTH-1:0]  data_in_i;
output wire ready_in_o,valid_out_o;
output reg[WIDTH-1:0]  data_out_o;
//internal register
reg[WIDTH-1:0] data_store;
reg is_full;



assign ready_in_o  = ~is_full;
assign valid_out_o = is_full;
always@(posedge clk_i)
begin
	if(rst_i)
	begin
		ready_in_o <= 0;
		valid_out_o <= 0;
		data_out_o <= 0;
		data_store <= 0;
		is_full <= 0;
	end
	else
	begin
		if(valid_in_i && ready_in_o)
		begin
			data_store <= data_in_i;
			is_full <= 1;
		end
		if(valid_out_o && ready_out_i)
		begin
			data_out_o <= data_store;
			is_full <= 0;
		end
	end
end
endmodule
