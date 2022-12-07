function E = mysum(varargin)
   E  = 0;
   for i=1:nargin
       E = E + varargin{i};
   end
end