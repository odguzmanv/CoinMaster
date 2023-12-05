# CoinMaster
Coin counter with FPGA.

Se utilizan sensores infrarojos a distintas alturas para que detecten las distintas denominaciones de monedas, esto dependera de las divisas que se manejen, en el caso de los pesos Colombianos manejamos 5 monedas distintas, de 50, 100, 200, 500 y 1000 pesos, por lo que usamos 5 emisores de luz infrarojos y 5 fotoreceptores, se alimentan con 12 voltios y se hizo un divisor de tension para sacar solo 5 voltios en cada fotoreceptor y conectar ese nodo a la FPGA en los pines GPIO.

Empezamos utilizando el botón de la FPGA para hacer la sumatoria de las monedas, 50 pesos como se ve en el siguiente video. Luego agregamos las demás denominaciones en los demás botones disponibles.

https://github.com/odguzmanv/CoinMaster/assets/60590466/8b5d4ee1-dfef-466e-9dd5-769ea6189e6c

Luego conectamos la hilera de sensores y pasamos las monedas como se verá en el siguiente video.

https://github.com/odguzmanv/CoinMaster/assets/60590466/89b7918f-a87e-43ae-97d6-30ca02f948ea

A continuación realizamos el bosquejo del diseño de la carcasa del proyecto, y aunque es un poco burdo o no es un corte láser, lo mostramos a continuación.

![case2](https://github.com/odguzmanv/CoinMaster/assets/60590466/68790419-9812-450c-b886-a45bc4f00d73)
![case1](https://github.com/odguzmanv/CoinMaster/assets/60590466/9ae96bed-4ddc-4e11-abcc-64a86f5e2516)

Esquemático de uno de los módulos del sensor implementado para la detección de monedas.

![sensorLtspice](https://github.com/odguzmanv/CoinMaster/assets/152459433/c7354c5e-5f86-4cd9-b7b0-83e482eabf2b)

