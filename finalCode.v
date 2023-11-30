module finalCode(coin,display,an,CLK_50,LED,rst);
	input [4:0]coin;
	input CLK_50;
	input rst;
	output [7:0]an;
	output [3:0]LED;
	output [6:0]display;
	
	reg [7:0]acarreo = 0;
	integer i;
	reg done;
		
	reg [27:0]contador;
	reg [6:0]display;
	reg [31:0]currency;
	reg [4:0]comb;
	reg [7:0]an;
	
	reg [24:0]clk;
	
	assign LED = coin[3:0];
	
	initial begin
		an = 8'b11111110;
		currency = 0;
		clk = 0;
	end
	
	always @(posedge CLK_50) begin
		clk = clk + 1'b1;
	end
	
	always @(posedge clk[15]) begin
		if (an==8'b11111110) an = 8'b11111101;
		else if (an==8'b11111101) an = 8'b11111011;
		else if (an==8'b11111011) an = 8'b11110111;
		else if (an==8'b11110111) an = 8'b11101111;
		else if (an==8'b11101111) an = 8'b11011111;
		else if (an==8'b11011111) an = 8'b10111111;
		else if (an==8'b10111111) an = 8'b01111111;
		else an = 8'b11111110;
		
		
		for(i=7,done=0; i>=0 & done==0;i=i-1) begin
			if (an[i]==0) begin
				done = 1;
			end
		end
		
		if (i==0) begin
			case(currency[3:0])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==1) begin
			case(currency[7:4])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==2) begin
			case(currency[11:8])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==3) begin
			case(currency[15:12])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==4) begin
			case(currency[19:16])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==5) begin
			case(currency[23:20])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==6) begin
			case(currency[27:24])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
		else if(i==7) begin
			case(currency[31:28])
				4'b0000: display = 7'b1000000;
				4'b0001: display = 7'b1111001;
				4'b0010: display = 7'b0100100;
				4'b0011: display = 7'b0110000;
				4'b0100: display = 7'b0011001;
				4'b0101: display = 7'b0010010;
				4'b0110: display = 7'b0000010;
				4'b0111: display = 7'b1111000;
				4'b1000: display = 7'b0000000;
				4'b1001: display = 7'b0011000;
				default: display = 7'b1111111;
			endcase
		end
	end
		
	always @(posedge CLK_50) begin
	
			if (rst==0) currency = 0;
	
		if (coin[0]==1'b1 | comb[0]==1'b1) begin
			contador = contador + 1;
			
			if (contador > 25_000_000) begin
				contador = 0;
				comb = 5'b00000;
			end
			
			if (coin[0] == 1'b1) comb[0]=1'b1;
			if (coin[1] == 1'b1) comb[1]=1'b1;
			if (coin[2] == 1'b1) comb[2]=1'b1;
			if (coin[3] == 1'b1) comb[3]=1'b1;
			if (coin[4] == 1'b1) comb[4]=1'b1;
			
			//if (contador == 25_000_000) LED = ~comb;
			
			if (contador == 25_000_000) begin
			
				case(comb)
					5'b00001 : begin
						if (currency[3:0] == 0) currency = currency + 5;
						else begin
							currency[3:0] = 0;
							acarreo[0] = 1;
						end		
					end
					5'b00011 : begin
						if (~(currency[7:4]=='d9)) begin
							currency[7:4] = currency[7:4] + 1;
						end
						else begin
							currency[7:4] = 0;
							acarreo[1] = 1;
						end		
					end
					5'b00111 : begin
						if (currency[7:4]<'d8) begin
							currency[7:4] = currency[7:4] + 'd2;
						end
						else begin
							if (currency[7:4]=='d9) currency[7:4] = 1;
							else currency[7:4]= 0;
							acarreo[1] = 1;
						end		
					end
					5'b01111 : begin
						if (currency[7:4]<'d5) begin
							currency[7:4] = currency[7:4] + 'd5;
						end
						else begin
							if (currency[7:4]=='d5) currency[7:4] = 0;
							else if (currency[7:4]=='d6) currency[7:4] = 'd1;
							else if (currency[7:4]=='d7) currency[7:4] = 'd2;
							else if (currency[7:4]=='d8) currency[7:4] = 'd3;
							else if (currency[7:4]=='d9) currency[7:4] = 'd4;
							acarreo[1] = 1;
						end		
					end
					5'b11111 : begin
						if (~(currency[11:8]=='d9)) begin
							currency[11:8] = currency[11:8] + 1;
						end
						else begin
							currency[11:8] = 0;
							acarreo[2] = 1;
						end		
					end
					default: currency = currency;
				endcase
				
				// ACARREOS _________________________________________________________________________________
				
				if (acarreo[0]==1) begin
					if (~(currency[7:4]=='d9)) begin
						currency[7:4] = currency[7:4] + 1;
					end
					else begin
						currency[7:4] = 0;
						acarreo[1:0] = 2'b10;
					end
				end
				
				if (acarreo[1]==1) begin
					if (~(currency[11:8]=='d9)) begin
						currency[11:8] = currency[11:8] + 1;
					end
					else begin
						currency[11:8] = 0;
						acarreo[2:1] = 2'b10;
					end
				end
				
				if (acarreo[2]==1) begin
					if (~(currency[15:12]=='d9)) begin
						currency[15:12] = currency[15:12] + 1;
					end
					else begin
						currency[15:12] = 0;
						acarreo[3:2] = 2'b10;
					end
				end
				
				if (acarreo[3]==1) begin
					if (~(currency[19:16]=='d9)) begin
						currency[19:16] = currency[19:16] + 1;
					end
					else begin
						currency[19:16] = 0;
						acarreo[4:3] = 2'b10;
					end
				end
				
				if (acarreo[4]==1) begin
					if (~(currency[23:20]=='d9)) begin
						currency[23:20] = currency[23:20] + 1;
					end
					else begin
						currency[23:20] = 0;
						acarreo[5:4] = 2'b10;
					end
				end
				
				if (acarreo[5]==1) begin
					if (~(currency[27:24]=='d9)) begin
						currency[27:24] = currency[27:24] + 1;
					end
					else begin
						currency[27:24] = 0;
						acarreo[6:5] = 2'b10;
					end
				end
				
				if (acarreo[6]==1) begin
					if (~(currency[31:28]=='d9)) begin
						currency[31:28] = currency[31:28] + 1;
					end
					else begin
						currency[31:28] = 0;
						acarreo[6] = 0;
					end
				end
				acarreo = 0;
			end	
		end
	end
	
endmodule
