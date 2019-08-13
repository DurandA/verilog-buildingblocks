module top(input clk, input btn, output [7:0] led,
	input RASP_IO02, output RASP_IO03, input RASP_IO04, output RASP_IO14, input RASP_IO15, output RASP_IO17, input RASP_IO18, output RASP_IO27, input RASP_IO22, output RASP_IO23);
	// ring oscillator

	wire [4:0] buffers_in, buffers_out;
	assign buffers_in = {RASP_IO22, RASP_IO18, RASP_IO15, RASP_IO04, RASP_IO02};
	assign buffers_out = {RASP_IO23, RASP_IO27, RASP_IO17, RASP_IO14, RASP_IO03};

	(* keep *)
	TRELLIS_SLICE #(
		.LUT0_INITVAL(16'h1111)
	) buffers [4:0] (
		.A0(buffers_in),
		.B0(1'b0),
		.C0(1'b0),
		.D0(1'b0),
		.F0(buffers_out)
	);

	// frequency counter

	reg [23:0] counter = 0;
	always @(posedge RASP_IO02) begin
		counter <= counter + 1;
	end

	// control

	assign led[7] = counter[23];
endmodule
