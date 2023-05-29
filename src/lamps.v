module DarkRoomLighting(
  input wire clk,
  input wire reset,
  input wire button,
  output reg [5:0] room_light
);
  
  localparam [5:0] LIGHT_THRESHOLD_LOW = 6'b000000;
  localparam [5:0] LIGHT_THRESHOLD_HIGH = 6'b111111;
  
  localparam STATE_LIGHT_ON = 1'b0;
  localparam STATE_LIGHT_OFF = 1'b1;
  
  reg state;
  
 always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= STATE_LIGHT_ON;
    end else begin
      case (state)
        STATE_LIGHT_ON:
          if (button)
            state <= STATE_LIGHT_OFF;
        STATE_LIGHT_OFF:
          if (!button)
            state <= STATE_LIGHT_ON;
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      STATE_LIGHT_ON:
        room_light <= LIGHT_THRESHOLD_HIGH;
      STATE_LIGHT_OFF:
        room_light <= LIGHT_THRESHOLD_LOW;
    endcase
  end
endmodule



