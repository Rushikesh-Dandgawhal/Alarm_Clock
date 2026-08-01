/*********************************************************************************
Module Name :- Top module RTL.

Author      :- Rushikesh P. Dandgawhal.

Email       :- rushikeshdandgawhal@gmail.com

Date        :- 29/07/2026

*********************************************************************************/
module alarm_clock_top(clock,
                      reset,
                      key,
                      time_button,
                      alarm_button,
                      fastwatch,
                      alarm_sound,
		              display_time_ms_hr,
             	      display_time_ls_hr,
             	      display_time_ms_min,
             	      display_time_ls_min);

input clock,
      reset,
      time_button,
      alarm_button,
      fastwatch;

input [3:0] key;

output alarm_sound;

output [7:0] display_time_ms_hr,
             display_time_ls_hr,
             display_time_ms_min,
             display_time_ls_min;

wire one_second,
     one_minute,
     load_new_c,
     load_new_a,
     show_current_time,
     show_a,
     shift,
     reset_count;

wire [3:0] key_buffer_ms_hr,
           key_buffer_ls_hr,
           key_buffer_ms_min,
           key_buffer_ls_min,
           current_time_ms_hr,
           current_time_ls_hr, 
           current_time_ms_min,
           current_time_ls_min, 
           alarm_time_ms_hr,
           alarm_time_ls_hr,
           alarm_time_ms_min,
           alarm_time_ls_min;
//instance of lower sub-modules

// Instance of timing generation module
timing_generator tgen1 (.clock(clock),
               .reset(reset),
               .fastwatch(fastwatch),
               .one_second(one_second),
               .one_minute(one_minute),
               .reset_count(reset_count));

// Instance of counter module
counter count1 (.one_minute(one_minute),
                .new_current_time_ms_min(key_buffer_ms_min),
                .new_current_time_ls_min(key_buffer_ls_min),
                .new_current_time_ms_hr(key_buffer_ms_hr),
                .new_current_time_ls_hr(key_buffer_ls_hr),
                .load_new_c(load_new_c),
                .clock(clock),
                .reset(reset),
                .current_time_ms_min(current_time_ms_min),
                .current_time_ls_min(current_time_ls_min),
                .current_time_ms_hr(current_time_ms_hr),
                .current_time_ls_hr(current_time_ls_hr));

// Instance of alarm register module
Alarm_Register alreg1 (.new_alarm_ms_hr(key_buffer_ms_hr),
                  .new_alarm_ls_hr(key_buffer_ls_hr),
                  .new_alarm_ms_min(key_buffer_ms_min),
                  .new_alarm_ls_min(key_buffer_ls_min),
                  .load_new_alarm(load_new_a),
                  .clock(clock),
                  .reset(reset),
                  .alarm_time_ms_hr(alarm_time_ms_hr),
                  .alarm_time_ls_hr(alarm_time_ls_hr),
                  .alarm_time_ms_min(alarm_time_ms_min),
                  .alarm_time_ls_min(alarm_time_ls_min));

// Instance of key register module
keyreg keyreg1 (.reset(reset),
                .clock(clock),
                .shift(shift),
                .key(key),
                .key_buffer_ls_min(key_buffer_ls_min),
                .key_buffer_ms_min(key_buffer_ms_min),
                .key_buffer_ls_hr(key_buffer_ls_hr),
                .key_buffer_ms_hr(key_buffer_ms_hr));

// Instance of FSM controller module
fsm fsm1 (.clock(clock),
          .reset(reset),
          .one_second(one_second),
          .time_button(time_button),
          .alarm_button(alarm_button),
          .key(key),
          .load_new_a(load_new_a),
          .show_a(show_a),
          .reset_count(reset_count),
          .show_new_time(show_current_time),
          .load_new_c(load_new_c),
          .shift(shift));

// Instance of lcd_driver_4 module
lcd_display_4 lcd_disp (.alarm_time_ms_hr(alarm_time_ms_hr),
                       .alarm_time_ls_hr(alarm_time_ls_hr),
                       .alarm_time_ms_min(alarm_time_ms_min),
                       .alarm_time_ls_min(alarm_time_ls_min),
                       .current_time_ms_hr(current_time_ms_hr),
                       .current_time_ls_hr(current_time_ls_hr),
                       .current_time_ms_min(current_time_ms_min),
                       .current_time_ls_min(current_time_ls_min),
                       .key_ms_hr(key_buffer_ms_hr),
                       .key_ls_hr(key_buffer_ls_hr),
                       .key_ms_min(key_buffer_ms_min),
                       .key_ls_min(key_buffer_ls_min),
                       .show_a(show_a),
                       .show_current_time(show_current_time),
                       .display_time_ms_hr(display_time_ms_hr),
                       .display_time_ls_hr(display_time_ls_hr),
                       .display_time_ms_min(display_time_ms_min),
                       .display_time_ls_min(display_time_ls_min),
                       .sound_a(alarm_sound));

endmodule