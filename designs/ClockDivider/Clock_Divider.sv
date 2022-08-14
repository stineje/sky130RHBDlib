module Clock_Divider(
  input logic   CLK,

  output logic  CLK_2, CLK_4, CLK_8;

);

  logic qn_fp1, qn_fp2, qn_fp3;
  fp1 (.D(q_fp1), .CLK(CLK)), .Q(CLK_2), .QN(qn_fp1)) flopr;
  fp2 (.D(qn_fp2), .CLK(qn_fp1)), .Q(CLK_4), .QN(qn_fp2)) flopr;
  fp3 (.D(qn_fp3), .CLK(qn_fp2)), .Q(CLK_8), .QN(qn_fp3)) flopr;
endmodule

module flopr(
  input logic   D,CLK,reset,

  output logic  Q, QN
);

  always_ff @(posedge CLK, posedge reset)
  begin
    if (reset)
    begin
      Q <= 0;
      QN <= 1;
    end
    else
    begin
      Q <= D;
      QN <= ~D;
    end
  end

endmodule



