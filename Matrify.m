for i=1:size(pointStore,2)
    Est(i)=pointStore(i).Value;
    Low(i)=pointStore(i).Value-pointStore(i).Lower;
    Up(i)=pointStore(i).Upper-pointStore(i).Value;
end
x=linspace(1,60,60);

%% plotting
hold on
% plot(x,R(10,1),'-r')
p=ezplot(num2str(R(10,1)),[0,61,14,26]);
set(p,'Color','r');
errorbar(x,Est,Low,Up,'x')
hold off