`timescale 1ns/1ps

/*********************************************************************************
Module Name :- Top Module Testbench

Author      :- Rushikesh P. Dandgawhal

Date        :- 31/07/2026

*********************************************************************************/

module alarm_clock_top_tb;

//--------------------------------------------------
// Inputs
//--------------------------------------------------
reg clock;
reg reset;
reg [3:0] key;
reg time_button;
reg alarm_button;
reg fastwatch;

//--------------------------------------------------
// Outputs
//--------------------------------------------------
wire alarm_sound;

wire [7:0] display_time_ms_hr;
wire [7:0] display_time_ls_hr;
wire [7:0] display_time_ms_min;
wire [7:0] display_time_ls_min;

//--------------------------------------------------
// DUT
//--------------------------------------------------

alarm_clock_top DUT
(
    .clock(clock),
    .reset(reset),
    .key(key),
    .time_button(time_button),
    .alarm_button(alarm_button),
    .fastwatch(fastwatch),

    .alarm_sound(alarm_sound),

    .display_time_ms_hr(display_time_ms_hr),
    .display_time_ls_hr(display_time_ls_hr),
    .display_time_ms_min(display_time_ms_min),
    .display_time_ls_min(display_time_ls_min)
);

//--------------------------------------------------
// Clock Generation
//--------------------------------------------------

initial
begin
    clock = 0;
    forever #5 clock = ~clock;
end

//--------------------------------------------------
// Monitor
//--------------------------------------------------

initial
begin
    $monitor("T=%0t Reset=%b Key=%d TimeBtn=%b AlarmBtn=%b Fast=%b Alarm=%b",
             $time,
             reset,
             key,
             time_button,
             alarm_button,
             fastwatch,
             alarm_sound);
end

//--------------------------------------------------
// Stimulus
//--------------------------------------------------

initial
begin

    //----------------------------
    // Initial values
    //----------------------------
    reset        = 1;
    key          = 4'd10;      // NOKEY
    time_button  = 0;
    alarm_button = 0;
    fastwatch    = 0;

    //----------------------------
    // Apply Reset
    //----------------------------
    #20;
    reset = 0;

    //----------------------------
    // Enable Fast Watch
    //----------------------------
    #20;
    fastwatch = 1;

    #3000;

    fastwatch = 0;

    //------------------------------------------------
    // Enter Current Time = 12:34
    //------------------------------------------------

    #20;

    // MS Hour = 1
    key = 4'd1;
    #40;
    key = 4'd10;
    #40;

    // LS Hour = 2
    key = 4'd2;
    #40;
    key = 4'd10;
    #40;

    // MS Minute = 3
    key = 4'd3;
    #40;
    key = 4'd10;
    #40;

    // LS Minute = 4
    key = 4'd4;
    #40;
    key = 4'd10;
    #40;

    //----------------------------
    // Load Current Time
    //----------------------------

    time_button = 1;
    #40;
    time_button = 0;

    //------------------------------------------------
    // Enter Alarm Time = 12:36
    //------------------------------------------------

    #100;

    // MS Hour = 1
    key = 4'd1;
    #40;
    key = 4'd10;
    #40;

    // LS Hour = 2
    key = 4'd2;
    #40;
    key = 4'd10;
    #40;

    // MS Minute = 3
    key = 4'd3;
    #40;
    key = 4'd10;
    #40;

    // LS Minute = 6
    key = 4'd6;
    #40;
    key = 4'd10;
    #40;

    //----------------------------
    // Load Alarm Time
    //----------------------------

    alarm_button = 1;
    #40;
    alarm_button = 0;

    //------------------------------------------------
    // Run the clock continuously
    //------------------------------------------------

    fastwatch = 1;

    // Run long enough for complete verification
    #2500000;

    $stop;

end

endmodule