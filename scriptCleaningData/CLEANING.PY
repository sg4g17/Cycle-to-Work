import os

with open('usd-eur.txt') as infile, open('out.txt', 'w') as outfile:
    name=infile.name
    row=1
    outfile.write(infile.readline())
    next(infile)
    for line in infile:
        #remove blank lines
        if not line.strip(): continue  # skip the empty line
        col = line.split(',')
        average=(float(col[2])+float(col[3]))/2
        line= str(row)+","+str(average)+'\n'
        row=row+1
        outfile.write(line)  # non-empty line. Write it
os.remove(name)
os.rename(outfile.name,name)
      











        

