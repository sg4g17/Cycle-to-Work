
import pandas as pd
import os
import glob

#expand table
# all_files = glob.glob(os.path.join(path, '*-gbp.txt'))  
# next(all_files)
path = './'
all_files = glob.glob(os.path.join('*-gbp.txt'))  
all_files2 = glob.glob(os.path.join('*-gbp.txt'))
for BaseC in all_files2[1:]:
    with open(BaseC) as target: 
        first_name = target.readline(4)
        all_files = glob.glob(os.path.join('*-gbp.txt'))  
        for fileCurrent in all_files[1:]:
            with open(fileCurrent) as fileC,open('out.txt', 'w') as outfile:
                next(target)
                if(target.name!=fileC.name):
                    second_name=fileC.readline(3)
                    next(fileC)
                    name=first_name+second_name
                    outfile.write(name+'\n')
                    for line1,line2 in zip(target,fileC):
                        line1=line1.replace('\n', '') 
                        line2=line2.replace('\n', '') 
                        v=float(line1)
                        v1=float(line2)
                        value=v/v1
                        outfile.write(str(value)+'\n')
                    outfile.close()
                    filename=name+".txt"
                    os.rename(outfile.name,filename)
            fileC.close()
            target.seek(0, 0)
    target.close()

    




all_files = glob.glob(os.path.join(path, '*-*.txt'))     
df_from_each_file = (pd.read_csv(f) for f in all_files)
concatenated_df = pd.concat(df_from_each_file, axis=1)
concatenated_df.to_csv('out.csv',index=False)



