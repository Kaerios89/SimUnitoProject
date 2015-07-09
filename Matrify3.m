load('PointStore10Composite.mat')
x=linspace(1,60,60);
for i=1:size(pointStore,2)
    Est(i)=pointStore(i).Value;
    Low(i)=pointStore(i).Value-pointStore(i).Lower;
    Up(i)=pointStore(i).Upper-pointStore(i).Value;
end
errorbar(x,Est,Low,Up,'bx')