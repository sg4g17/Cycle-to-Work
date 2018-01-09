


%RELEVANT VALUES !!!!!!!

filename = 'matrixFormatted.xlsx';
[num, txt, raw] = xlsread(filename);
good=num;

currenciesName=raw(1,2:273);
e=zeros(1,272);

for z=length(currenciesName):-1: 1
   
  num=good;
  currenciesName=raw(1,2:273) ; 
  a=currenciesName(z);
   
  currency1 = cellfun(@(S) S(1:3), a, 'Uniform', 0);
  currency2 = cellfun(@(S) S(5:7), a, 'Uniform', 0);
  currency1 = char(currency1);
  currency2 = char(currency2);

%identify the column that will be the  and removeing all columns containing
%at least one input 
columnTarget=[];
mstd=zeros(2,size(num,2));
j=1;
for i=size(num,2):-1: 1
     currentCurrency=currenciesName{1,i};
     
     if(isequal(currentCurrency(1:3),currency1) || isequal(currentCurrency(5:7),currency2) || isequal(currentCurrency(1:3),currency2) || isequal(currentCurrency(5:7),currency1) )
          if (isequal(currentCurrency(1:3),currency1) && isequal(currentCurrency(5:7),currency2) )
              columnTarget=num(:,i);
              num(:,i)=[];
              currenciesName(:,i)=[];      
          else
            num(:,i)=[];
            currenciesName(:,i)=[];
            
          end
     else 
          mstd(1,j)=mean(num(:,i));
          mstd(2,j)=std(num(:,i));
          num(:,i)=num(:,i)-mean(num(:,i));
          num(:,i)=num(:,i)/std(num(:,i));
          j=j+1;
           
     end
  
end


[N, p] = size(num);
Y = [num(:,1:p) ones(N,1)];

f = columnTarget;
f = f - mean(f);
f = f/std(f);

%split in training and test set 


  ii=randperm(N);
  %model
  training=Y(ii(1:(N*0.75)),:);
  test=Y(ii((N*0.75)+1:N) ,:);
  fTraining=f(ii(1:(N*0.75)),:);
  fTest=f(ii((N*0.75)+1:N) ,:);     


gamma=8.0;

cvx_begin quiet
    variable w2( p+1 )
    minimize( norm(training*w2-fTraining) + gamma*norm(w2,1) );
cvx_end


e(z)=sum((((test*w2)-fTest).^2)/(N/2))*100;   
     
         
end   
        


     






