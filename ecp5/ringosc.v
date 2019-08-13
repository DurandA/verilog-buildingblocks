module top(input clk, input btn, output [7:0] led);
	// ring oscillator

	wire [100:0] buffers_in, buffers_out;
	assign buffers_in = {buffers_out[99:0], buffers_out[100]};

	(* keep *)
	TRELLIS_SLICE #(
		.LUT0_INITVAL(16'h0007)
	) initializer (
		.A0(buffers_in[0]),
		.B0(btn),
		.C0(1'b0),
		.D0(1'b0),
		.F0(buffers_out[0])
	);

	(* keep *)
	TRELLIS_SLICE #(
		.LUT0_INITVAL(16'h0002)
	) buffers [99:0] (
		.A0(buffers_in[100:1]),
		.B0(1'b0),
		.C0(1'b0),
		.D0(1'b0),
		.F0(buffers_out[100:1])
	);

	// frequency counter

	reg [23:0] counter = 0;
	always @(posedge buffers_out[100]) begin
		counter <= counter + 1;
	end

	// control

	assign led[7] = counter[23];
endmodule
