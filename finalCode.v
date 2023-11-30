// Módulo finalCode con entradas y salidas
module finalCode(coin,display,an,CLK_50,LED,rst);
	// Entradas
	input [4:0] coin; // Entrada de 5 bits para la moneda
	input CLK_50; // Reloj de entrada de 50 MHz
	input rst; // Señal de reset

	// Salidas
	output [7:0] an; // Salida para anodos, 8 bits
	output [3:0] LED; // Salida para LEDs, 4 bits
	output [6:0] display; // Salida para el display de 7 segmentos

	// Declaración de variables internas
	reg [7:0] acarreo = 0; // Acarreo, inicializado a 0
	integer i; // Variable entera para iteraciones
	reg done; // Registro para indicar finalización
		
	reg [27:0] contador; // Contador de 28 bits
	reg [6:0] display; // Registro para el display de 7 segmentos
	reg [31:0] currency; // Registro para manejar la moneda, 32 bits
	reg [4:0] comb; // Registro de combinación, 5 bits
	reg [7:0] an; // Registro para anodos, 8 bits
	
	reg [24:0] clk; // Registro para manejar el reloj, 25 bits

	// Asignación de LED a los 4 bits menos significativos de coin
	assign LED = coin[3:0];

	// Bloque inicial para configurar valores iniciales
	initial begin
		an = 8'b11111110; // Inicializar anodos
		currency = 0; // Inicializar el valor de las monedas a 0
		clk = 0; // Inicializar el reloj a 0
	end

	// Este bloque siempre se ejecuta en el flanco positivo del reloj CLK_50.
	always @(posedge CLK_50) begin
		clk = clk + 1'b1; // Incrementa el contador de reloj clk
	end

	// Este bloque se ejecuta en el flanco positivo del bit 15 del contador clk.
	always @(posedge clk[15]) begin
		// Este conjunto de if-else rota los bits de 'an' para activar diferentes anodos en secuencia.
		if (an==8'b11111110) an = 8'b11111101;
		else if (an==8'b11111101) an = 8'b11111011;
		else if (an==8'b11111011) an = 8'b11110111;
		else if (an==8'b11110111) an = 8'b11101111;
		else if (an==8'b11101111) an = 8'b11011111;
		else if (an==8'b11011111) an = 8'b10111111;
		else if (an==8'b10111111) an = 8'b01111111;
		else an = 8'b11111110;
		
		// Bucle for para determinar qué anodo está activo actualmente.
		for(i=7,done=0; i>=0 & done==0;i=i-1) begin
			if (an[i]==0) begin
				done = 1;
			end
		end

		// Esta sección actualiza el display en función del valor de la 'currency'.
		// Cada if-else if comprueba el valor de 'i' para saber qué parte de 'currency' mostrar.
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
		
	// Bloque always que se ejecuta en cada flanco positivo del reloj CLK_50.
	always @(posedge CLK_50) begin
		// Si se activa la señal de reset, reinicia el valor de las monedas a 0.
			if (rst==0) currency = 0;
		
		// Este bloque maneja la detección de monedas y el control de tiempo.
		if (coin[0]==1'b1 | comb[0]==1'b1) begin
			contador = contador + 1;

			// Reinicia el contador y comb después de un tiempo específico.
			if (contador > 25_000_000) begin
				contador = 0;
				comb = 5'b00000;
			end

			// Actualiza comb basado en la entrada de coin.
			if (coin[0] == 1'b1) comb[0]=1'b1;
			if (coin[1] == 1'b1) comb[1]=1'b1;
			if (coin[2] == 1'b1) comb[2]=1'b1;
			if (coin[3] == 1'b1) comb[3]=1'b1;
			if (coin[4] == 1'b1) comb[4]=1'b1;
			
			//if (contador == 25_000_000) LED = ~comb; // Prueba

			// Lógica para actualizar currency y manejar el acarreo.
			if (contador == 25_000_000) begin

				// Lógica para actualizar currency y acarreos
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
				
				// Lógica para manejar acarreos en los diferentes segmentos de currency.
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

				// Reinicia el registro de acarreo una vez procesado.
				acarreo = 0;
			end	
		end
	end
	
endmodule
