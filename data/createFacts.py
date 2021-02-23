import csv
import random
#import matplotlib.pyplot as plt
import math
'''
Hechos(venta ,  horaid ,  clienteid , 
    empleadoid ,  tiendaid ,  promocionid , 
    preciodeventaporunidad , unidadesvendidas  , gananciaporunidad )
'''


#with open('hechos.csv', mode='w') as hechos_file:
with open('hechos_minis.csv', mode='w') as hechos_file:

    hechos_writer = csv.writer(
        hechos_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    hechos_writer.writerow(["venta",
        "hora_id",
        "cliente_id",
        "empleado_id",
        "tienda_id",
        "promocion_id", 
        "precio_de_venta_por_unidad",
        "unidades_vendidas" ,
        "ganancia_por_unidad",
    ])

    # determining the values of the parameters
    mu_horas = 1000
    sigma_horas = 380  # 15 dias
    for new in range(1, 10):
          nuevorenglon=[]
          #venta
          nuevorenglon.append(new)

          #hora_id
          temp = math.floor(abs(random.gauss(mu_horas, sigma_horas)))      
          if new % 230 == 0:
               mu_horas = mu_horas + 400
               sigma_horas = sigma_horas + 1
          nuevorenglon.append(temp)
          
          #cliente_id
          mu_cliente = 50
          sigma_cliente = 10
          nuevorenglon.append(math.floor(
               abs(random.normalvariate(mu_cliente, sigma_cliente))))

          #empleado_id
          mu_empleado = 25
          sigma_empleado = 5
          nuevorenglon.append(math.floor(
               abs(random.normalvariate(mu_empleado, sigma_empleado))))
          

          #tienda_id
          mu_tienda = 34
          sigma_tienda = 6
          nuevorenglon.append(math.floor(
             abs(random.normalvariate(mu_tienda, sigma_tienda))))


          #promocion_id
          

          mu_unidades_entrantes = 200000
          sigma_unidades_entrantes = mu_unidades_entrantes
          unidades_entrantes = math.floor(random.gauss(mu_unidades_entrantes, sigma_unidades_entrantes))
          while unidades_entrantes < 0:
              unidades_entrantes = math.floor(random.gauss(
                    mu_unidades_entrantes, sigma_unidades_entrantes))

          caso = 0
          maker = 0
          USD = random.randint(0, 1) 
          # Caso Dolares
          if USD == 0:
               if unidades_entrantes < 500000:
                    caso = 1
                    maker = 0.095
               if unidades_entrantes >= 500000:
                    caso = 2
                    maker = 0.090
               if unidades_entrantes >= 1000000:
                    caso = 3
                    maker = 0.084
               if unidades_entrantes >= 1500000:
                    caso = 4
                    maker = 0.080
               if unidades_entrantes >= 3000000:
                    caso = 5
                    maker = 0.075
               if unidades_entrantes >= 5000000:
                    caso = 6
                    maker = 0.069
               if unidades_entrantes >= 10000000:
                    caso = 7
                    maker = 0.060
               if unidades_entrantes >= 15000000:
                    caso = 8
                    maker = 0.050
               if unidades_entrantes >= 20000000:
                    caso = 9
                    maker = 0.040
               if unidades_entrantes >= 30000000:
                    caso = 10
                    maker = 0.030
          else :
               if unidades_entrantes < 500000:
                    caso = 11
                    maker = 0.5
               if unidades_entrantes >= 500000:
                    caso = 12
                    maker = 0.490
               if unidades_entrantes >= 1000000:
                    caso = 13
                    maker = 0.480
               if unidades_entrantes >= 1500000:
                    caso = 14
                    maker = 0.440
               if unidades_entrantes >= 3000000:
                    caso = 15
                    maker = 0.420
               if unidades_entrantes >= 5000000:
                    caso = 16
                    maker = 0.400
               if unidades_entrantes >= 10000000:
                    caso = 17
                    maker = 0.370
               if unidades_entrantes >= 15000000:
                    caso = 18
                    maker = 0.300
               if unidades_entrantes >= 20000000:
                    caso = 19
                    maker = 0.200
               if unidades_entrantes >= 30000000:
                    caso = 20
                    maker = 0.100

          nuevorenglon.append(caso) 


          #precio_de_venta_por_unidad
          if  USD == 0:
              precio_de_venta_por_unidad = math.floor(random.randint(1500, 2000))/100
          else :
              precio_de_venta_por_unidad = math.floor(
                  random.randint(40, 60))/1000
          
          nuevorenglon.append(precio_de_venta_por_unidad)
          

          #unidades_vendidas
          #(x/precio actual)(1-maker)
          unidades_vendidas = (unidades_entrantes /
                               precio_de_venta_por_unidad)*(1.0 - maker) +1
          nuevorenglon.append(unidades_vendidas)


          #ganancia_por_unidad
          #[(x_(divisa_)mxn/precio actual)] * (maker) / USD_dados
          ganancia_por_unidad = (unidades_entrantes /
                               precio_de_venta_por_unidad)* maker/ unidades_vendidas
          nuevorenglon.append(ganancia_por_unidad)
          hechos_writer.writerow(nuevorenglon)
            
