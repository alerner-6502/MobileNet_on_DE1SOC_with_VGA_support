module vga_controller
(
	input  bit_clk,  //
	input  rst_n,
	output fb_clk,   
	output vga_clk,  //
	output reg vga_hsync,
	output reg vga_vsync,
	output reg vga_blank,
	output vga_sync,
	output reg frame_rst
);

	assign vga_clk = bit_clk;
	assign vga_sync = 1'b0;
	
	reg [9:0] x_cnt, y_cnt;
	
	initial begin
		x_cnt = 10'd0;
		y_cnt = 10'd0;
	end
	
	always @ (posedge bit_clk or negedge rst_n) begin
		if ( !rst_n )begin
			x_cnt <= 10'd0;
			y_cnt <= 10'd0;
		end
		else if(x_cnt == 10'd799) begin
			x_cnt <= 0;
			if(y_cnt == 10'd523) y_cnt <= 10'd0;
			else y_cnt <= y_cnt + 10'd1;
		end
		else begin
			x_cnt <= x_cnt + 10'd1;
		end
		
		vga_hsync <= (x_cnt < 10'd704);
		vga_vsync <= (y_cnt < 10'd522);
		vga_blank <= (x_cnt >= 10'd200) & (x_cnt < 10'd520) & (y_cnt >= 10'd100) & (y_cnt < 10'd340);
		
		frame_rst <= (y_cnt == 10'd97);
	end
	
	assign fb_clk = bit_clk | ~vga_blank;
	
endmodule