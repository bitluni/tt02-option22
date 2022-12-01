module option24 (
    input [7:0] io_in,
    output wire [7:0] io_out
);
parameter WORD_COUNT = 32;

wire clk = io_in[0];
wire nclk = !clk;
wire write = io_in[1];
wire [3:0] din = io_in[5:2];

reg [8 * WORD_COUNT - 1: 0] buffer;

assign io_out = buffer[7:0];

integer i;

always@(clk) begin
    if(clk)
        buffer[15:12] <= din;
    else
        if(write)
            buffer = {buffer[7:0], buffer[8 * WORD_COUNT - 1:16],din,buffer[11:8]};
        else
            buffer = {buffer[7:0], buffer[8 * WORD_COUNT - 1:8]};
end

endmodule
