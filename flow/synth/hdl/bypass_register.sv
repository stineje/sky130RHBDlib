module bypass_register (
    input        tdi, 
    input        clockDR, 
    input        shiftDR,
    output logic tdo
);

always @(posedge clockDR) begin
    tdo <= tdi & shiftDR;   // 10.1.1 (b)
end

endmodule // bypass_register