`include "code.sv"
module tb;
wire clk_i,rst_i;
wire valid_in_i,ready_out_i;
reg[WIDTH-1:0]  data_in_i;
wire ready_in_o,valid_out_o;
reg[WIDTH-1:0]  data_out_o;


middle#(.WIDTH(8)) dut (.clk_i(clk_i), .rst_i(rst_i), 
				.valid_in_i(valid_in_i),.ready_in_o(ready_in_o),.data_in_i(data_in_i), 
				.valid_out_o(valid_out_o), .data_out_o(data_out_o), .ready_out_i(ready_out_i));
initial 
begin
	#5 clk_i = ~clk_i
end

  initial begin
    rst_i       = 1;
    valid_in_i = 0;
    ready_out_i = 0;
    data_in_i  = 0;

    // reset
    #20;
    rst_i = 0;

    // send first data
    @(posedge clk_i);
    data_in_i  = 8'hA5;
    valid_in_i = 1;
    ready_out_i = 0;   

    // hold for few cycles (backpressure)
    repeat (3) @(posedge clk_i);

    ready_out_i = 1;

    // stop driving input
    @(posedge clk_i);
    valid_in_i = 0;

    // send second data
    @(posedge clk_i);
    data_in_i  = 8'h3C;
    valid_in_i = 1;

    @(posedge clk_i);
    valid_in_i = 0;

    // finish
    repeat (5) @(posedge clk_i);
    $finish;
  end


endmodule
