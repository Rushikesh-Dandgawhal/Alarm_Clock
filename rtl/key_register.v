/*********************************************************************************
Module Name :- Key Register. It is a shift register which stores the key time.

Author      :- Rushikesh P. Dandgawhal.

Email       :- rushikeshdandgawhal@gmail.com

Date        :- 26/07/2026

*********************************************************************************/

module keyreg(reset,clock, shift, key, key_buffer_ls_min, key_buffer_ms_min, key_buffer_ms_hr, key_buffer_ls_hr);
    input reset,
          clock,
          shift;
    input [3:0] key;
    output reg [3:0] key_buffer_ls_hr,
                     key_buffer_ls_min,
                     key_buffer_ms_hr,
                     key_buffer_ms_min;


always @(posedge clock or posedge reset) 
begin
    if(reset)
    begin
        key_buffer_ls_min <= 0;
        key_buffer_ls_hr  <= 0;
        key_buffer_ms_min <= 0;
        key_buffer_ms_hr  <= 0;
end
    else if(shift == 1)
    begin
        key_buffer_ms_hr  <= key_buffer_ls_hr;
        key_buffer_ls_hr  <= key_buffer_ms_min;
        key_buffer_ms_min <= key_buffer_ls_min;
        key_buffer_ls_min <= key;
    end
end
endmodule

              
