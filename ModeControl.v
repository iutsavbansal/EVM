scale 1ns / 1ps

module buttoncontrol(
input clock,
input button,
input reset,
output reg valid_vote
);

reg[30:0] counter;

always @(posedge clock)
begin
     if(reset)
           counter <= 0;
      else
      begin
          if(button==1 & counter<100000001)
              counter <= counter+1;
           else if(!button)
               counter <= 0;
      end
end

always @(posedge clock)
begin
    if(reset)
            valid_vote <= 1'b0;
     begin 
     if(counter == 100000000)
             valid_vote <= 1'b1;
     else
             valid_vote <= 1'b0;
     end
end

endmodule