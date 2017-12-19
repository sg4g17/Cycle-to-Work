import os

with open('rub-gbpOrig.txt') as infile, open('out.txt', 'w') as outfile, open('time.txt','w') as time:
    name=infile.name
    row=1
    outfile.write(infile.readline())
    next(infile)
    for line in infile:
        #remove blank lines
        if not line.strip(): continue  # skip the empty line
        col = line.split(',')
        average=(float(col[2])+float(col[3]))/2
        line=str(average)+'\n'
        month=col[1]+'\n'
        row=row+1
        time.write(str(month))
        outfile.write(line)  # non-empty line. Write it
os.remove(name)
os.rename(outfile.name,name)
      











        

