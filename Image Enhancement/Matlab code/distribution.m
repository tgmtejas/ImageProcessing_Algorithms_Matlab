function [histogram_values,cdfValues, pdf, cdf]  = distribution(f, x ,y) 

histogram_values = zeros(1,256);

% histogram_values = double(histogram_values);

for i = 1:x
      for j = 1:y
          
          p = f(i,j);
          
          histogram_values(1,p+1)= histogram_values(1,p+1)+ 1;
      end
end

pdf = histogram_values/(x*y);

cdfValues = zeros(1,256);
% cdfValues = double(cdfValues);


cdfValues(1,1)= histogram_values(1,1);


for i=2:1:x
    
    cdfValues(1,i)= histogram_values(1,i)+ cdfValues(1,(i-1));
    
end

cdf = cdfValues/(x*y);

end

