/*********************************************************************************
Module Name :- Timing Generator.

Author      :- Rushikesh P. Dandgawhal.

Email       :- rushikeshdandgawhal@gmail.com

Date        :- 28/07/2026

*********************************************************************************/
module timing_generator(clock, reset, reset_count, fastwatch, one_second, one_minute);

input clock,
      reset, 
      reset_count, 
      fastwatch;

output one_second, 
       one_minute;

reg [13:0] count;
reg one_second, 
    one_minute,
    one_minute_reg;



//One minute pulse generation
always @(posedge clock or posedge reset)
begin
    if (reset)
    begin
        count <= 14'b0;
        one_minute_reg <= 0;
    end
    else if (reset_count)
    begin
        count <= 14'b0;
        one_minute_reg <= 0;
    end
    else if (count[13:0] == 14'd15359)
    begin
        count <= 14'b0;
        one_minute_reg <= 1'b1;
    end
    else
    begin
        count <= count + 1'b1;
        one_minute_reg <= 1'b0;
    end
end

//one second pulse generation
always @(posedge clock or posedge reset)
begin
    if(reset)
    begin
        one_second <= 14'b0;
    end
    else if (reset_count)
    begin
        one_second <= 14'b0;
    end
    else if (count[7:0] == 8'd255)
    begin
        one_second <= 1'b1;
    end
    else
    begin
        one_second <= 1'b0;
    end
end

//fastwatch pulse generation for make fast counting
always@(*)
begin
    if(fastwatch)
    begin
        one_minute = one_second;
    end
    else
    begin
        one_minute = one_minute_reg;
    end
end

endmodule
