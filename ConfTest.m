dentro=0;
dentro_up=0;
dentro_dw=0;
fuori=0;
fuori_up=0;
fuori_dw=0;
rowtab=double.empty;
for i=1:size(pointStore,2)
    if (pointStore(i).Lower < appo(10,1))&&(pointStore(i).Upper > appo(10,1))
        %siamo dentro
        dentro=dentro+1;
        if pointStore(i).Value < appo(10,1)
            %dentro sotto
            dentro_dw=dentro_dw+1;
        else
            %dentro sopra
            dentro_up=dentro_up+1;
        end
    else
        %siamo fuori
        fuori=fuori+1;
        if pointStore(i).Value < appo(10,1)
            %fuori sotto
            fuori_dw=fuori_dw+1;
        else
            %fuori sopra
            fuori_up=fuori_up+1;
        end
    end
end
rowtab=cat(2,rowtab,dentro,fuori,dentro_up,dentro_dw,fuori_up,fuori_dw);