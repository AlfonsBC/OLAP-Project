import csv





with open('horas.csv', mode='w') as horas_file:
    horas_writer = csv.writer(
        horas_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    horas_writer.writerow(["hora_id", "hora_desc", "dia_id"])

    with open('dia.csv') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        horas_id = 0
        dia_id=0
        for row in csv_reader:
            if horas_id == 0:
                horas_id += 1
                dia_id += 1
            else:
                for hora in range(0,24):
                    horas_writer.writerow(
                        [horas_id, "'" + str(hora)+":00 " + str(row[1]) + "'", dia_id])
                    horas_id += 1
                dia_id += 1
                
