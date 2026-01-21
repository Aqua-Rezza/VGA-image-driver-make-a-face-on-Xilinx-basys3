`timescale 1ns / 1ps

// image generator of a road and a sky 640x480 @ 60 fps

module smiley(
	input clk,           // 100 MH
	output o_hsync,      // horizontal sync
	output o_vsync,	     // vertical sync
	output [3:0] o_red,
	output [3:0] o_blue,
	output [3:0] o_green  
);

	reg [9:0] counter_x = 0;  // horizontal counter
	reg [9:0] counter_y = 0;  // vertical counter
	reg [3:0] r_red = 0;
	reg [3:0] r_blue = 0;
	reg [3:0] r_green = 0;
	
	reg reset = 0;  // for PLL
	
	wire clk25MHz;

	// clk divider 100 MHz to 25 MHz
clock_divider vga(
.clk_in (clk),
.clk_out (clk25MHz)
);

	// counter and sync generation
	always @(posedge clk25MHz)  // horizontal counter
		begin 
			if (counter_x < 799)
				counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				counter_x <= 0;              
		end  // always 
	
	always @ (posedge clk25MHz)  // vertical counter
		begin 
			if (counter_x == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (counter_y < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						counter_y <= counter_y + 1;
					else
						counter_y <= 0;              
				end  
		end  
	// hsync and vsync output assignments
	assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1:0;   // vsync high for 2 counts

	// pattern generate
		always @ (posedge clk)
		begin
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
			if (counter_y < 135)
				begin              
					r_red <= 4'hF;    // white
					r_blue <= 4'hF;
					r_green <= 4'hF;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
			else if (counter_y >= 135 && counter_y < 205)
				begin 
					if (counter_x < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 324 && counter_x < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 2
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 3
			else if (counter_y >= 205 && counter_y < 217)
				begin 
					if (counter_x < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 324 && counter_x < 371)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 371 && counter_x < 383)
						begin 
							r_red <= 4'h0;    // black
							r_blue <= 4'h0;
							r_green <= 4'h0;
						end  
					else if (counter_x >= 383 && counter_x < 545)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end 
					else if (counter_x >= 545 && counter_x < 557)
						begin 
							r_red <= 4'h0;    // black
							r_blue <= 4'h0;
							r_green <= 4'h0;
						end  
					else if (counter_x >= 557 && counter_x < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end 
					else if (counter_x >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end 
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			else if (counter_y >= 217 && counter_y < 305)
				begin
					if (counter_x < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 324 && counter_x < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 4
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (counter_y >= 305 && counter_y < 310)
				begin
					if (counter_x < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 324 && counter_x < 371)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 371 && counter_x < 557)
						begin 
							r_red <= 4'h0;    // black
							r_blue <= 4'h0;
							r_green <= 4'h0;
						end  
					else if (counter_x >= 557 && counter_x < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end 
					else if (counter_x >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 5
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 6
			else if (counter_y >= 305 && counter_y < 414)
				begin
					if (counter_x < 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 324 && counter_x < 604)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  
					else if (counter_x >= 604)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
				end 
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 6
			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 7
			else if (counter_y <= 414)
				begin              
					r_red <= 4'hF;    // white
					r_blue <= 4'hF;
					r_green <= 4'hF;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 7
		end  
						
	// end pattern generate

	
	// color output assignments
	// only output the colors if the counters are within the adressable video time constraints
	assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 4'h0;
	assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 4'h0;
	assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 4'h0;
	
	
endmodule  
