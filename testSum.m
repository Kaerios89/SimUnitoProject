test=AvElement.empty;
for i=1:10
    test=cat(1,test,AvElement(exprnd(5),exprnd(20)));
end