/*********************************************************************************
Module Name :- Counter.

Author      :- Rushikesh P. Dandgawhal.

Email       :- rushikeshdandgawhal@gmail.com

Date        :- 28/07/2026

*********************************************************************************/
module counter(clock, reset, one_minute, load_new_c,
               new_current_time_ms_hr,
               new_current_time_ms_min,
               new_current_time_ls_hr,
               new_current_time_ls_min,
               current_time_ms_hr,
               current_time_ms_min,
               current_time_ls_hr,
               current_time_ls_min);

input clock,
      reset, 
      one_minute, 
      load_new_c;

input [3:0] new_current_time_ms_hr,
            new_current_time_ms_min,
            new_current_time_ls_hr,
            new_current_time_ls_min;

output [3:0] current_time_ms_hr,
                 current_time_ms_min,
                 current_time_ls_hr,
                 current_time_ls_min;

reg [3:0] current_time_ms_hr,
            current_time_ms_min,
            current_time_ls_hr,
            current_time_ls_min;

// For asynchronous reset
always @(posedge clock or posedge reset)
begin
    if (reset)
    begin
        current_time_ms_hr <= 4'd0;
        current_time_ms_min <= 4'd0;
        current_time_ls_hr <= 4'd0;
        current_time_ls_min <= 4'd0;
    end
    //for loading new current time into the current time .
    else if (load_new_c)
    begin                                                       //for example ms_hr --- ls_hr --- ms_min --- ls_min.    cureent_time
        current_time_ms_hr <= new_current_time_ms_hr;           //             2         3          5          9          00.00
        current_time_ms_min <= new_current_time_ms_min;         //             0         9          5          9          10.00
        current_time_ls_hr <= new_current_time_ls_hr;           //             0         0          5          9          01.00
        current_time_ls_min <= new_current_time_ls_min;         //             0         0          0          9          00.10
    end
    //checking for one minute and incrementing the current time accordingly.
    else if (one_minute)
    begin
        //for first case if the current time is 23:59 then it should be reset to 00:00.
        if (current_time_ms_hr == 4'd2 && current_time_ls_hr == 4'd3 && current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9)
        begin
            current_time_ms_hr <= 4'd0;
            current_time_ls_hr <= 4'd0;
            current_time_ms_min <= 4'd0;
            current_time_ls_min <= 4'd0;
        end
// Handle hour rollover when LS hour digit reaches 9
// (09:59 -> 10:00 and 19:59 -> 20:00)
        else if (current_time_ls_hr == 4'd9 && current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9)
        begin
            current_time_ms_hr <= current_time_ms_hr + 1'd1;
            current_time_ls_hr <= 4'd0;
            current_time_ms_min <= 4'd0;
            current_time_ls_min <= 4'd0;
        end
        //for third case if the current time is 00:59 then it should be reset to 01:00.
        else if (current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9)
        begin
            current_time_ls_hr <=current_time_ls_hr + 1'd1;
            current_time_ms_min <= 4'd0;
            current_time_ls_min <= 4'd0;
        end
        //for fourth case if the current time is 00:09 then it should be reset to 00:10.
        else if (current_time_ls_min == 4'd9)
        begin
            current_time_ms_min <= current_time_ms_min + 1'd1;
            current_time_ls_min <= 4'd0;
        end
        else
        begin
            current_time_ls_min <= current_time_ls_min + 1'd1;
        end
    end
end
endmodule
