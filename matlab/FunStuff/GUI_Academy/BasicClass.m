
%{ 
    %Set-up Progress Bar [make this separate function, openProgressBar.m]
        % waitincrement=length(RefCheckMatrix).*length(Range); % Defined twice                        
        waitincrement=length(Range);
        waitposition=0;
        h = waitbar(0,'Sphinctalyzing','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
        setappdata(h,'canceling',0);
%}
classdef BasicClass
   properties
      Value
   end
   
   methods
       
      function obj = BasicClass(val)
         if nargin == 1
            if isnumeric(val)
               obj.Value = val;
            else
               error('Value must be numeric')
            end
         end
      end
      
      function r = roundOff(obj)
         r = round([obj.Value],2);
      end
      
      function r = multiplyBy(obj,n)
         r = [obj.Value] * n;
      end
      
      function r = plus(o1,o2)
         r = o1.Value + o2.Value;
      end
   end
end