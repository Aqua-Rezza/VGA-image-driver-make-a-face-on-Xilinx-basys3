`timescale 1ns / 1ps

module clock_divider(clk_in, clk_out);
input clk_in;
output wire clk_out;
reg [1:0]m;
initial m=0;
always@ (posedge clk_in)
begin
   m<=m+1;
   end

assign clk_out=m[1];

endmodule