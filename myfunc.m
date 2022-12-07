function E = myfunc(A,B,C,D)
   if(nargin < 4) ,D = 1,end
   if(nargin < 3) ,C = 2,end
   if(nargin < 2) ,B = 3,end
   if(nargin == 0),A = 4,end
   E = A + B + C + D;
end