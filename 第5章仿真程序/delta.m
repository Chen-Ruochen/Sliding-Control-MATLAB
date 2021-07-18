function [tout]=tolt(tin)
if tin<=1.0
    tout=0.40;
elseif tin<=3.0
    tout=0.70;
elseif tin<=5.0
    tout=0.60;
elseif tin<=7.0
    tout=0.40;
elseif tin<=9.0
    tout=0.70;
elseif tin<=10.0
    tout=0.30;
else
    tout=0.50;
end
tout=tout;