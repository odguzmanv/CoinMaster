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
		// Ciclo de control para el registro 'an' que determina qué anodo está activo.
		if (an==8'b11111110) an = 8'b11111101; // Apaga el segundo bit menos significativo (an[1]).
		else if (an==8'b11111101) an = 8'b11111011; // Apaga el tercer bit menos significativo (an[2]).
		else if (an==8'b11111011) an = 8'b11110111; // Apaga el cuarto bit menos significativo (an[3]).
		else if (an==8'b11110111) an = 8'b11101111; // Apaga el quinto bit menos significativo (an[4]).
		else if (an==8'b11101111) an = 8'b11011111; // Apaga el sexto bit menos significativo (an[5]).
		else if (an==8'b11011111) an = 8'b10111111; // Apaga el séptimo bit menos significativo (an[6]).
		else if (an==8'b10111111) an = 8'b01111111; // Apaga el bit más significativo (an[7]).
		else an = 8'b11111110; // Reinicia 'an' a su estado inicial con solo an[0] apagado.
		
		// Bucle for para determinar qué anodo está activo actualmente.
		for(i=7,done=0; i>=0 & done==0;i=i-1) begin
			if (an[i]==0) begin
				done = 1;
			end
		end

|		// Esta sección actualiza el display en función del valor de la 'currency'.
		// Cada if-else if comprueba el valor de 'i' para saber qué parte de 'currency' mostrar.
		if (i==0) begin // Si 'i' es 0, significa que se está actualizando el dígito más a la derecha del display.
			case(currency[3:0]) // Selecciona qué mostrar basado en los 4 bits menos significativos de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==1) begin // Si 'i' es 1, significa que se está actualizando el segundo dígito más a la derecha en el display.
			case(currency[7:4]) // Selecciona qué mostrar basado en los siguientes 4 bits de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==2) begin // Si 'i' es 2, significa que se está actualizando el tercer dígito más a la derecha en el display.
			case(currency[11:8]) // Selecciona qué mostrar basado en los bits de la posición 11 a 8 de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==3) begin // Si 'i' es 3, se está actualizando el cuarto dígito más a la derecha en el display.
			case(currency[15:12]) // Selecciona qué mostrar basado en los bits de la posición 15 a 12 de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==4) begin  Si 'i' es 4, se está actualizando el quinto dígito más a la derecha en el display.
			case(currency[19:16]) // Selecciona qué mostrar basado en los bits de la posición 19 a 16 de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==5) begin // Si 'i' es 5, se está actualizando el sexto dígito más a la derecha en el display.
			case(currency[23:20]) // Selecciona qué mostrar basado en los bits de la posición 23 a 20 de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==6) begin// Si 'i' es 6, se está actualizando el séptimo dígito más a la derecha en el display.
			case(currency[27:24]) // Selecciona qué mostrar basado en los bits de la posición 27 a 24 de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
			endcase
		end
		else if(i==7) begin // Si 'i' es 7, se está actualizando el octavo (último) dígito en el display.
			case(currency[31:28]) // Selecciona qué mostrar basado en los bits de la posición 31 a 28 de 'currency'.
				4'b0000: display = 7'b1000000; // Muestra '0' en el display de 7 segmentos.
				4'b0001: display = 7'b1111001; // Muestra '1' en el display de 7 segmentos.
				4'b0010: display = 7'b0100100; // Muestra '2' en el display de 7 segmentos.
				4'b0011: display = 7'b0110000; // Muestra '3' en el display de 7 segmentos.
				4'b0100: display = 7'b0011001; // Muestra '4' en el display de 7 segmentos.
				4'b0101: display = 7'b0010010; // Muestra '5' en el display de 7 segmentos.
				4'b0110: display = 7'b0000010; // Muestra '6' en el display de 7 segmentos.
				4'b0111: display = 7'b1111000; // Muestra '7' en el display de 7 segmentos.
				4'b1000: display = 7'b0000000; // Muestra '8' en el display de 7 segmentos.
				4'b1001: display = 7'b0011000; // Muestra '9' en el display de 7 segmentos.
				default: display = 7'b1111111; // En cualquier otro caso, apaga todos los segmentos.
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
			if (coin[0] == 1'b1) comb[0]=1'b1; // Si el primer bit de 'coin' es 1, establece el primer bit de 'comb' a 1.
			if (coin[1] == 1'b1) comb[1]=1'b1; // Si el segundo bit de 'coin' es 1, establece el segundo bit de 'comb' a 1.
			if (coin[2] == 1'b1) comb[2]=1'b1; // Si el tercer bit de 'coin' es 1, establece el tercer bit de 'comb' a 1.
			if (coin[3] == 1'b1) comb[3]=1'b1; // Si el cuarto bit de 'coin' es 1, establece el cuarto bit de 'comb' a 1.
			if (coin[4] == 1'b1) comb[4]=1'b1; // Si el quinto bit de 'coin' es 1, establece el quinto bit de 'comb' a 1.
			
			//if (contador == 25_000_000) LED = ~comb; // Prueba

			// Lógica para actualizar currency y manejar el acarreo.
			if (contador == 25_000_000) begin

				// Lógica para actualizar currency y acarreos. Depende de la moneda ingresada, se agrega un 1 por cada sensor cubierto.
				case(comb)
					5'b00001 : begin // Cuando 'comb' es 00001 (solo el bit menos significativo está activo).
						if (currency[3:0] == 0) currency = currency + 5; // Si los 4 bits menos significativos de 'currency' son 0, suma 5.
						else begin
							currency[3:0] = 0; // Si no, reinicia los 4 bits menos significativos de 'currency' a 0.
							acarreo[0] = 1; // Y establece el primer bit de 'acarreo' a 1 para indicar un acarreo.
						end		
					end
					5'b00011 : begin // Cuando 'comb' es 00011 (los dos bits menos significativos están activos).
						if (~(currency[7:4]=='d9)) begin // Comprueba si los bits de la posición 7 a 4 de 'currency' son diferentes de 9.
							currency[7:4] = currency[7:4] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
						end
						else begin
							currency[7:4] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
							acarreo[1] = 1; // Y establece el segundo bit de 'acarreo' a 1 para indicar un acarreo.
						end		
					end
					5'b00111 : begin // Cuando 'comb' es 00111 (los tres bits menos significativos están activos).
						if (currency[7:4]<'d8) begin // Comprueba si los bits 7 a 4 de 'currency' son menores que 8.
							currency[7:4] = currency[7:4] + 'd2; // Si es así, suma 2 a esta parte de 'currency'.
						end
						else begin
							if (currency[7:4]=='d9) currency[7:4] = 1; // Si los bits son 9, los reinicia a 1.
							else currency[7:4]= 0; // Si los bits son 8, los reinicia a 0.
							acarreo[1] = 1; // En ambos casos, establece el segundo bit de 'acarreo' a 1 para indicar un acarreo.
						end		
					end
					5'b01111 : begin // Cuando 'comb' es 01111 (los cuatro bits menos significativos están activos).
						if (currency[7:4]<'d5) begin // Comprueba si los bits 7 a 4 de 'currency' son menores que 5.
							currency[7:4] = currency[7:4] + 'd5; // Si es así, suma 5 a esta parte de 'currency'.
						end
						else begin // Esta serie de condiciones ajusta los bits 7 a 4 de 'currency' dependiendo de su valor actual.
							if (currency[7:4]=='d5) currency[7:4] = 0; // Si es 5, lo reinicia a 0.
							else if (currency[7:4]=='d6) currency[7:4] = 'd1; // Si es 6, lo ajusta a 1.
							else if (currency[7:4]=='d7) currency[7:4] = 'd2; // Si es 7, lo ajusta a 2.
							else if (currency[7:4]=='d8) currency[7:4] = 'd3; // Si es 8, lo ajusta a 3.
							else if (currency[7:4]=='d9) currency[7:4] = 'd4; // Si es 9, lo ajusta a 4.
							acarreo[1] = 1; // En todos los casos, establece el segundo bit de 'acarreo' a 1 para indicar un acarreo.
						end		
					end
					5'b11111 : begin // Cuando 'comb' es 11111 (todos los bits están activos).
						if (~(currency[11:8]=='d9)) begin // Comprueba si los bits de la posición 11 a 8 de 'currency' son diferentes de 9.
							currency[11:8] = currency[11:8] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
						end
						else begin
							currency[11:8] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
							acarreo[2] = 1; // Y establece el tercer bit de 'acarreo' a 1 para indicar un acarreo.
						end		
					end
					default: currency = currency; // En cualquier otro caso no definido, mantiene el valor actual de 'currency'.
				endcase
				
				// ACARREOS _________________________________________________________________________________
				
				// Lógica para manejar acarreos en los diferentes segmentos de currency.
				if (acarreo[0]==1) begin // Comprueba si el primer bit de 'acarreo' está activo.
					if (~(currency[7:4]=='d9)) begin // Comprueba si los bits de la posición 7 a 4 de 'currency' son diferentes de 9.
						currency[7:4] = currency[7:4] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[7:4] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[1:0] = 2'b10; // Establece el segundo bit de 'acarreo' a 1 y el primero a 0.
					end
				end
				
				if (acarreo[1]==1) begin // Comprueba si el segundo bit de 'acarreo' está activo.
					if (~(currency[11:8]=='d9)) begin // Comprueba si los bits de la posición 11 a 8 de 'currency' son diferentes de 9.
						currency[11:8] = currency[11:8] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[11:8] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[2:1] = 2'b10; // Establece el tercer bit de 'acarreo' a 1 y el segundo a 0.
					end
				end
				
				if (acarreo[2]==1) begin // Comprueba si el tercer bit de 'acarreo' está activo.
					if (~(currency[15:12]=='d9)) begin // Comprueba si los bits de la posición 15 a 12 de 'currency' son diferentes de 9.
						currency[15:12] = currency[15:12] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[15:12] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[3:2] = 2'b10; // Establece el cuarto bit de 'acarreo' a 1 y el tercero a 0.
					end
				end
				
				if (acarreo[3]==1) begin // Comprueba si el cuarto bit de 'acarreo' está activo.
					if (~(currency[19:16]=='d9)) begin // Comprueba si los bits de la posición 19 a 16 de 'currency' son diferentes de 9.
						currency[19:16] = currency[19:16] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[19:16] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[4:3] = 2'b10; // Establece el quinto bit de 'acarreo' a 1 y el cuarto a 0.
					end
				end
				
				if (acarreo[4]==1) begin // Comprueba si el quinto bit de 'acarreo' está activo.
					if (~(currency[23:20]=='d9)) begin // Comprueba si los bits de la posición 23 a 20 de 'currency' son diferentes de 9.
						currency[23:20] = currency[23:20] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[23:20] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[5:4] = 2'b10; // Establece el sexto bit de 'acarreo' a 1 y el quinto a 0.
					end
				end
				
				if (acarreo[5]==1) begin // Comprueba si el sexto bit de 'acarreo' está activo.
					if (~(currency[27:24]=='d9)) begin // Comprueba si los bits de la posición 27 a 24 de 'currency' son diferentes de 9.
						currency[27:24] = currency[27:24] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[27:24] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[6:5] = 2'b10; // Establece el séptimo bit de 'acarreo' a 1 y el sexto a 0.
					end
				end
				
				if (acarreo[6]==1) begin // Comprueba si el séptimo bit de 'acarreo' está activo.
					if (~(currency[31:28]=='d9)) begin // Comprueba si los bits de la posición 31 a 28 de 'currency' son diferentes de 9.
						currency[31:28] = currency[31:28] + 1; // Si no son 9, incrementa esta parte de 'currency' en 1.
					end
					else begin
						currency[31:28] = 0; // Si son 9, reinicia esta parte de 'currency' a 0.
						acarreo[6] = 0; // Reinicia el séptimo bit de 'acarreo'.
					end
				end

				// Reinicia el registro de acarreo una vez procesado.
				acarreo = 0;
			end	
		end
	end
	
endmodule
