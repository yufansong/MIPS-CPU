`timescale 1ps/1ps
module test_cpu();
	
	reg reset;
	reg clk;
	reg UART_RX;
	wire [7:0] o_seg;
    wire [7:0] o_sel;
	wire [31:0] show_data_d;
	pipeline pp(clk, reset,o_seg, o_sel); 
	// pipeline pp(clk, reset,o_seg, o_sel,show_data_d);
	initial begin
		reset = 1;
		clk = 1;
        // UART_RX=1;
		#10 reset = 0;
		
	end
	
	always #5 clk = ~clk;
		
endmodule


// #104000 UART_RX=0;

// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=1;
// #104000 UART_RX=0;
// #104000 UART_RX=0;

// #104000 UART_RX=1;
// #104000 UART_RX=1;

// #104000 UART_RX=0;

// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=1;
// #104000 UART_RX=0;

// #104000 UART_RX=1;
// #104000 UART_RX=1;

// #104000 UART_RX=0;

// #104000 UART_RX=0;
// #104000 UART_RX=1;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=1;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;

// #104000 UART_RX=1;
// #104000 UART_RX=1;

// #104000 UART_RX=0;

// #104000 UART_RX=1;
// #104000 UART_RX=1;
// #104000 UART_RX=0;
// #104000 UART_RX=1;
// #104000 UART_RX=1;
// #104000 UART_RX=0;
// #104000 UART_RX=0;
// #104000 UART_RX=0;

// #104000 UART_RX=1;