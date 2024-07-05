module modeControl(
input clock,
input reset,
input mode,
input valid_vote_casted,
input [7:0] candidate1_vote,
input [7:0] candidate2_vote,
input [7:0] candidate3_vote,
input [7:0] candidate4_vote,
input candidate1_button_press,
input candidate2_button_press,
input candidate3_button_press,
input candidate4_button_press,
output reg [7:0] led
);
reg [30:0] counter;

always @(posedge clock)
begin
      if(reset)
         counter <= 0;
      else if(valid_vote_casted)
          counter <= counter+1;
      else if(counter !=0 & counter < 100000000)
            counter <= counter + 1;
       else
            counter <=0;
end
always @(posedge clock)
begin
    if(reset)
          led <= 0;
     else
     begin
         if(mode==0 & counter!=0) //mode 0 -> voting mode, mode 1 -> result mode
                 led <= 8'hff;
          else if(mode==0 & counter == 0)
                  led <= 8'h00;
          else if(mode==1)
          begin
             if(candidate1_button_press)
                   led <= candidate1_vote;
             else if(candidate2_button_press)
                   led <= candidate2_vote;
             else if(candidate3_button_press)
                   led <= candidate3_vote;
             else if(candidate4_button_press)
                   led <= candidate4_vote;
          end
end
end
endmodule