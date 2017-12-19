
%RELEVANT VALUES !!!!!!!

filename = 'matrixFormatted.xlsx';
[num, txt, raw] = xlsread(filename);

currenciesName=raw(1,2:257);
inp = input('Insert the two currency excanghes in the format AA-BB : ','s');
currency1=inp(1:3);
currency2=inp(5:7);

x = inp;

%identify the column that will be the  and removeing all columns containing
%at least one input 
columnTarget=[];
mstd=zeros(2,size(num,2));
j=1;
for i=size(num,2):-1: 1
     currentCurrency=currenciesName{1,i};
     
     if(isequal(currentCurrency(1:3),currency1) || isequal(currentCurrency(5:7),currency2) || isequal(currentCurrency(1:3),currency2) || isequal(currentCurrency(5:7),currency1) )
          if strcmp(currentCurrency,x)~=1   
            num(:,i)=[];
            currenciesName(:,i)=[];
          else
            columnTarget=num(:,i);
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


%shift target column in the last position



%Normalize and add bias


[N, p] = size(num);
Y = [num(:,1:p) ones(N,1)];

f = columnTarget;
f = f - mean(f);
f = f/std(f);


disp('Start');
gamma=10;
incr=2
rangeTooBig=0
outcome=zeros(3,1)
for k=1:100
    cvx_begin quiet
        variable w2( p+1 );
        minimize( norm(Y*w2-f) + gamma*norm(w2,1) );
   cvx_end
   
  [iNzero] = find(abs(w2) > 1e-5);
  length(iNzero')
 if length(iNzero')<=3 
     if length(iNzero')==3
        fh2 = Y*w2;
        figure(1),clf
        plot(f, fh2, 'co', 'LineWidth', 2),
        legend('Regression', 'Sparse Regression');
        disp('Relevant variables');
        ii=randperm(N);
        %model
        training=Y(ii(1:(N*0.75)),:);
        test=Y(ii((N*0.75)+1:N) ,:);
        fTraining=f(ii(1:(N*0.75)),:);
        fTest=f(ii((N*0.75)+1:N) ,:);
        eTr=sum((((training*w2)-fTraining).^2)/(N/2))*100;
        e=sum((((test*w2)-fTest).^2)/(N/2))*100;        
        outcome=iNzero;
        
        break;   
     else          
         gamma=gamma-2;
         rangeTooBig=1; 
     end
 end
 if rangeTooBig==1 
    incr=incr-0.3
    rangeTooBig=0
 end
 gamma=gamma+incr;
    
end
 
%denormalize!!


for j=1:length(outcome')
    Y(:,outcome(j,1))=Y(:,outcome(j,1))*mstd(2,outcome(j,1));
    Y(:,outcome(j,1))= Y(:,outcome(j,1))+mstd(1,outcome(j,1));
   
end



figure(2),clf
plot(Y(:,outcome(1,1)))
legend(currenciesName(1,outcome(1,1)))
xticks([0 53*1 53*2 53*3 53*4 53*5 53*6 53*7 53*8 53*9 53*10 53*11 53*12 53*13 53*14 53*15 53*16 53*17 53*18 1000 ]);
xticklabels({'dec/98','dec/99','dec/00','dec/01','dec/02','dec/03','dec/04','dec/05','dec/06','dec/07','dec/08','dec/09','dec/10','dec/11','dec/12','dec/13','dec/14','dec/15','dec/16','dec/17'});
xlabel('Time'); ylabel('Exchange Rates');
figure(3),clf
plot(Y(:,outcome(2,1)))
legend(currenciesName(1,outcome(2,1)))
xticks([0 53*1 53*2 53*3 53*4 53*5 53*6 53*7 53*8 53*9 53*10 53*11 53*12 53*13 53*14 53*15 53*16 53*17 53*18 1000 ]);
xticklabels({'dec/98','dec/99','dec/00','dec/01','dec/02','dec/03','dec/04','dec/05','dec/06','dec/07','dec/08','dec/09','dec/10','dec/11','dec/12','dec/13','dec/14','dec/15','dec/16','dec/17'});
xlabel('Time'); ylabel('Exchange Rates');
figure(4),clf
plot(Y(:,outcome(3,1)))
legend(currenciesName(1,outcome(3,1)))
xticks([0 53*1 53*2 53*3 53*4 53*5 53*6 53*7 53*8 53*9 53*10 53*11 53*12 53*13 53*14 53*15 53*16 53*17 53*18 1000 ]);
xticklabels({'dec/98','dec/99','dec/00','dec/01','dec/02','dec/03','dec/04','dec/05','dec/06','dec/07','dec/08','dec/09','dec/10','dec/11','dec/12','dec/13','dec/14','dec/15','dec/16','dec/17'});
xlabel('Time'); ylabel('Exchange Rates');
hold on









