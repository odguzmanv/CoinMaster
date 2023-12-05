# CoinMaster
Coin counter with FPGA.

Se utilizan sensores infrarojos a distintas alturas para que detecten las distintas denominaciones de monedas, esto dependera de las divisas que se manejen, en el caso de los pesos Colombianos manejamos 5 monedas distintas, de 50, 100, 200, 500 y 1000 pesos, por lo que usamos 5 emisores de luz infrarojos y 5 fotoreceptores, se alimentan con 12 voltios y se hizo un divisor de tension para sacar solo 5 voltios en cada fotoreceptor y conectar ese nodo a la FPGA en los pines GPIO.

Empezamos utilizando el botón de la FPGA para hacer la sumatoria de las monedas, 50 pesos como se ve en el siguiente video. Luego agregamos las demás denominaciones en los demás botones disponibles.

<iframe width="560" height="315" src="https://youtu.be/QKupDmu2JHQ" frameborder="0" allowfullscreen></iframe>

Luego conectamos la hilera de sensores y pasamos las monedas como se verá en el siguiente video.
