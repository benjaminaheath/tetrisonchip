//`include "/package/memory_p.sv"
module board(
    input logic clk,
    input logic wnr,
    input logic [4:0] rowid,
    input logic [19:0] in,
    input logic reset_n,
    output logic [19:0] out
);

    logic [19:0] mem [0:19];
    logic [4:0] i;

    assign out = mem[rowid];

    always_ff @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            foreach(mem[i]) mem[i] = '0;
            //for(i=0; i<20; i=i+1) mem[i] = '0;
        end
        else if(wnr) mem[rowid] <= in;
    end

endmodule