module votingMachine(
input clock,
input reset,
input mode,
input button1,
input button2,
input button3,
input button4,
output wire [7:0] led
);
 
wire valid_vote_1;
wire valid_vote_2;
wire valid_vote_3;
wire valid_vote_4;
wire cand1_vote_recvd;   
wire cand2_vote_recvd;   
wire cand3_vote_recvd;   
wire cand4_vote_recvd;
wire valid_vote_casted;

assign valid_vote_casted = valid_vote_1/valid_vote_2/valid_vote_3/valid_vote_4;
  
buttoncontrol bc1(
.clock(clock),
.button(button1),
.reset(reset),
.valid_vote(valid_vote_1)
);  

buttoncontrol bc2(
.clock(clock),
.button(button2),
.reset(reset),
.valid_vote(valid_vote_2)
);  

buttoncontrol bc3(
.clock(clock),
.button(button3),
.reset(reset),
.valid_vote(valid_vote_3)
);  

buttoncontrol bc4(
.clock(clock),
.button(button4),
.reset(reset),
.valid_vote(valid_vote_4)
);   

voteLogger VL(
.clock(clock),
.reset(reset),
.cand1_vote_valid(valid_vote_1),
.cand2_vote_valid(valid_vote_2),
.cand3_vote_valid(valid_vote_3),
.cand4_vote_valid(valid_vote_4),
.cand1_vote_recvd(cand1_vote_recvd),
.cand2_vote_recvd(cand2_vote_recvd),
.cand3_vote_recvd(cand3_vote_recvd),
.cand4_vote_recvd(cand4_vote_recvd)
);

modeControl MC(
.clock(clock),
.reset(reset),
.mode(mode),
.valid_vote_casted(),
.candidate1_vote(cand1_vote_recvd),
.candidate2_vote(cand2_vote_recvd),
.candidate3_vote(cand3_vote_recvd),
.candidate4_vote(cand4_vote_recvd),
.candidate1_button_press(valid_vote_1),
.candidate2_button_press(valid_vote_2),
.candidate3_button_press(valid_vote_3),
.candidate4_button_press(valid_vote_4),
.led(led)
);

endmodule