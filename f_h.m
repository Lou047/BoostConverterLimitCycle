%------------------------------------------------------
% Description: Flow map
%------------------------------------------------------
function sdot=f_h(s)

x=s(1:2);
q=s(3);
tau=s(4);

global L C R E;

tauD=1;
D1=(tau>=1 && q==2)||(tau<=0 && q==1);

if D1==0 
    if q==1
        A1=[0 -1/L;1/C -1/(R*C)];
        b1=[E/L;0];
        f1=A1*x+b1;        
        sdot=[f1;0;-1/tauD];
    else
        A2=[0 0;0 -1/(R*C)];
        b2=[E/L;0];
        f2=A2*x+b2;
        sdot=[f2;0;1/tauD];
    end
else
    if q==1
        A1=[0 -1/L;1/C -1/(R*C)];
        b1=[E/L;0];
        f1=A1*x+b1;        
        sdot=[f1;0;0];
    else
        A2=[0 0;0 -1/(R*C)];
        b2=[E/L;0];
        f2=A2*x+b2;
        sdot=[f2;0;0];
    end    
end

