module option22 (
    input wire [7:0] io_in, 
    output reg [7:0] io_out
);
parameter WORD_COUNT = 64;

wire clk = io_in[0];
wire reset = io_in[1];
wire write = io_in[2];
wire din = io_in[3];

reg [2:0] count;
reg [WORD_COUNT * 8 - 1:0] buffer;

always@(posedge clk or posedge reset) begin

    if(reset) begin
        count <= 3'd0;
        io_out <= 8'd0;
    end else 
    begin
        if(write) begin
            buffer <= {buffer[WORD_COUNT * 8 - 2:0], din};
            if(count == 3'b111) begin
                io_out <= {buffer[6:0],din};
            end
        end else begin
            buffer <= {buffer[WORD_COUNT * 8 - 2:0], buffer[WORD_COUNT * 8 - 1]};
            if(count == 3'b111) begin
                io_out <= {buffer[6:0],buffer[WORD_COUNT * 8 - 1]};
            end
        end
        count <= count + 3'd1;
    end
end
endmodule
