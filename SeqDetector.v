// 101 Sequence detector in behavioral verilog

module SeqDetector (clk,rst,X,Z);
 input X, clk, rst;
 output Z;
 reg[1:0] state, next_state;
 reg Z;
parameter [1:0] S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11; 
/*
     S0-> Reset state
     S1-> Received 1
     S2-> Recieved 10
     S3-> Received 101
     */

always @(posedge clk , negedge rst)
   if(!rst) state<=S0;
  else state<=next_state;
always @(*)
      begin
        case(state)
                S0:if(X) next_state=S1;
                   else  next_state=S0;
                   S1:if(X) next_state=S1;
                   else  next_state=S2;
                S2:if(X) next_state=S3;
                   else  next_state=S0;
                S3: if(X) next_state=S1;
                    else  next_state=S2;
        endcase 
      end

always @(state)
  begin
       Z = 0;
       case(state)
                S0:Z=0;
                S1:Z=0;
                S2:Z=0;
                S3:Z=1;
      endcase
  end
endmodule