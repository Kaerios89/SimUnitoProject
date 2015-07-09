%distribuzione composita con i seguenti parametri:
% uniforme(0,10)+uniforme(0,20)+norm(15,3)
% NOTA:tutto fratto 1000 in quanto parliamo di ms OK_TO_GO
function value=UniUniNormGen(~)
%         value=-10;
%         while (value<0 || value>30)
%         sumArr=unifrnd(0,1,48,1);
%         normval=(sum(sumArr)-24)*(2*3)+15;
%         value=(unifrnd(0,10)+unifrnd(0,20)+normval);
%         end
        appo=(unifrnd(0,10)+unifrnd(0,20)+normrnd(15,3));
        value=appo/1000;
end