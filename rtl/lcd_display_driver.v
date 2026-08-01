/*********************************************************************************
Module Name :- Lcd_Display_Driver with respect to single digit time display.

Author      :- Rushikesh P. Dandgawhal.

Email       :- rushikeshdandgawhal@gmail.com

Date        :- 29/07/2026

*********************************************************************************/
module lcd_display_driver(alarm_time,
                          current_time,
                          show_alarm,
                          show_new_time,
                          key,
                          display_time,
                          sound_alarm);

input [3:0] alarm_time;
input [3:0] current_time;
input show_alarm;
input show_new_time;
input [3:0] key;

output reg [7:0] display_time;
output reg sound_alarm;

reg [3:0] display_value;

localparam ZERO = 8'h30;
localparam ONE = 8'h31;
localparam TWO = 8'h32;
localparam THREE = 8'h33;
localparam FOUR = 8'h34;
localparam FIVE = 8'h35;
localparam SIX = 8'h36;
localparam SEVEN = 8'h37;
localparam EIGHT = 8'h38;
localparam NINE = 8'h39;
localparam ERROR = 8'h3A;

always @(*)
begin
    if (show_new_time)
        display_value = key;
    else if (show_alarm)
        display_value = alarm_time;
    else
        display_value = current_time;

    if(current_time == alarm_time)
        sound_alarm = 1'b1;
    else
        sound_alarm = 1'b0;
end

always @(*)
begin
    case(display_value)
        4'd0: display_time = ZERO;
        4'd1: display_time = ONE;
        4'd2: display_time = TWO;
        4'd3: display_time = THREE;
        4'd4: display_time = FOUR;
        4'd5: display_time = FIVE;
        4'd6: display_time = SIX;
        4'd7: display_time = SEVEN;
        4'd8: display_time = EIGHT;
        4'd9: display_time = NINE;
        default: display_time = ERROR; // For invalid input
    endcase
end
endmodule
    