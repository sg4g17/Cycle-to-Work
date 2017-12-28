import csv

csvFile = open("\import.csv", "r",encoding="utf-8")
reader2 = csv.reader(csvFile)
data1 = []
data2 = []
for item1 in reader2:
    data1.append(item1)
data2.append(data1[0])
data2.append(data1[8])
data2.append(data1[12])
data2.append(data1[28])
data2.append(data1[34])
data2.append(data1[39])
data2.append(data1[54])
data2.append(data1[72])
data2.append(data1[76])
data2.append(data1[80])
data2.append(data1[105])
data2.append(data1[108])
data2.append(data1[115])
data2.append(data1[118])
data2.append(data1[125])
data2.append(data1[153])
data2.append(data1[201])
data2.append(data1[204])
data2.append(data1[243])
data2.append(data1[250])
data2.append(data1[262])

test = zip(*data2)
data = []
for item2 in test:
        data.append(item2)

csvFile.close()
csvFile2 = open('\clean_import.csv','w',encoding="utf-8", newline='')
writer = csv.writer(csvFile2)

fin_data = []
fin_data.append(data[1])
fin_data.append(data[35])
item3 = 35
for item4 in range(1,26):
    item3 = item3 + 1
    fin_data.append(data[item3])


m = len(fin_data)
for i in range(m):
    writer.writerow(fin_data[i])

csvFile2.close()