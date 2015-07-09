function value=Erlang3Gen(mu)
    %generatore di un numero casuale distribuito secondo una Erlang 3, di
    %parametro mu. OK_TO_GO
    mu=mu^-1;
    appo=1;
    for i=1:3
        appo=appo*unifrnd(0,1);
    end
    appo=-log(appo);
    value=(appo*mu)/(3); %è così in quanto uso mu=1/lambda
end