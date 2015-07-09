function vett=fusion(a,b)
    vett=double.empty(1,0);
    for i=1:size(a,2)
        vett=[vett,a(i),b(i)];
    end
end