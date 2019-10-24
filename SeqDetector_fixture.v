//Sequence Detector testbench using tasks

`include "SeqDetector.v"
  module SeqDetector_fixture();
  reg X, clk, rst;
  wire Z;
initial
   $vcdpluson;
  initial
$monitor($time,"Reset=%b,Input=%b,Output=%b",rst,X,Z); SeqDetector d1(.clk(clk), .rst(rst), .X(X), .Z(Z)); initial
	begin
    	clk = 1'b0;
    	forever #5 clk= ~clk;
    end

task reset_task();
    begin
    	rst = 1'b0;
   		#10  rst = 1'b1;
    end 
endtask

task test ();
	begin
        X=1;
        #10 X=0;
        #10 X=1;
	end 
endtask

task test2 ();
	begin
        X=0;
        #10 X=0;
        #10 X=1;
	end 
endtask

task test3 ();
	begin
        X=0;
        #10 X=0;
        #10 X=0;
	end
endtask

task test4 ();
	begin
        X=0;
        #10 X=1;
        #10 X=0;
	end 
endtask

task main();
begin
	reset_task();
#20 test();
#20 test2();
#20 test3();
#20 test4();
#20 reset_task();
#20 reset_task();
#20 test();
#20 test2();
#20 test3();
#20 reset_task();
end
endtask

initial
	begin
	  main();
	  #2000 $finish;
	end
endmodule