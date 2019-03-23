%------------------------------------------------------
% Description: Jump set
% Return 0 if outside of D, and 1 if inside D
%------------------------------------------------------
function value = D_h(s)

x=s(1:2);
q=s(3);
tau=s(4);

D1=(tau>=1 && q==2)||(tau<=0 && q==1);

if D1
    value = 1;
else
    value = 0;
end
