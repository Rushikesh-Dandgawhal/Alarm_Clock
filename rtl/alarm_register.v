/*********************************************************************************
Module Name :- Alarm_Register.

Author      :- Rushikesh P. Dandgawhal.

Email       :- rushikeshdandgawhal@gmail.com

Date        :- 28/07/2026

*********************************************************************************/
module Alarm_Register(
    new_alarm_ms_hr,
    new_alarm_ls_hr,
    new_alarm_ms_min,
    new_alarm_ls_min,
    load_new_alarm,
    clock,
    reset,
    alarm_time_ms_hr,
    alarm_time_ls_hr,
    alarm_time_ms_min,
    alarm_time_ls_min);

input [3:0] new_alarm_ms_hr,
            new_alarm_ls_hr,
            new_alarm_ms_min,
            new_alarm_ls_min;

input load_new_alarm, clock, reset;

output reg [3:0] alarm_time_ms_hr,
                 alarm_time_ls_hr,
                 alarm_time_ms_min,
                 alarm_time_ls_min;

always @(posedge clock or posedge reset)
begin
    if(reset)
    begin
        alarm_time_ms_hr <= 4'b0;
        alarm_time_ls_hr <= 4'b0;
        alarm_time_ms_min <= 4'b0;
        alarm_time_ls_min <= 4'b0;
    end
    //if no reset, then load new alarm time
    else if(load_new_alarm)
    begin
        alarm_time_ms_hr <= new_alarm_ms_hr;
        alarm_time_ls_hr <= new_alarm_ls_hr;
        alarm_time_ms_min <= new_alarm_ms_min;
        alarm_time_ls_min <= new_alarm_ls_min;
    end
end
endmodule
