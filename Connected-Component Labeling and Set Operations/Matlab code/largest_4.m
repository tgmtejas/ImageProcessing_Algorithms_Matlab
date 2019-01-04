function final_4 = largest_4(flabel, num, f1)

% This function is used to determine the largest 4 components. 

% First, the components along with their pixel count are arranged in a
% matrix using the following FOR loop

num_of_elements = zeros(2, num);

% The number of pixels for each component can be found using the inbuilt
% MATLAB command nnz(). The code for the same is listed below.

% for i  = 1:num
%     num_of_elements(2,i) = i;
%     num_of_elements(1,i) = nnz(flabel == i);
% end

% Instead of using the nnz() function, the code is implemented using loops

for a = 1:num
    num_of_elements(2,a) = a;
    x = 0;
    for i = 1:256                  % The entire image will be scanned 
        for j = 1:256              % throughout for each label component 
            if flabel(i,j) == a    % 'a'. This value is stored in the 
                x = x+1;           % variable x.
            end
        end
    end
    num_of_elements(1,a) = x;
end
            

sorted_array = sortrows((num_of_elements)');

% The sortrows() functiion is used to sort the pixel count in ascending
% order. 
% When the pixel count is sorted, the component number is also
% accordingly sorted. 
% As the operator wors on columns, the transpose operator has been used.

% As the array is sorted in ascending operator, the following loop is used
% to extract the largest 4 components.
% These components will be in the last 4 cells of the first column.
% The component labels are extracted and stored in the 'largest_4_comp' 
% variable.

largest_4_comp = zeros(1,4);

for i = 1:4
    largest_4_comp(1,i) = sorted_array(num-i+1,2);
end

% The following FOR loop is used to trace the top 4 component labels in the
% flabel file. These four labels are retained and their value is set to
% the actual intensity. All other component labels are set to 0. Thus the 
% final image will consist of only the four largest components.

biggest_comp = zeros(256);
second_comp = zeros(256);
third_comp = zeros(256);
fourth_comp = zeros(256);

for i = 1:256
    for j = 1:256
        if flabel(i,j) == largest_4_comp(1,1)
            biggest_comp(i,j) = f1(i,j);
        elseif flabel(i,j) == largest_4_comp(1,2)
            second_comp(i,j) = f1(i,j);
        elseif flabel(i,j) == largest_4_comp(1,3)
            third_comp(i,j) = f1(i,j);
        elseif flabel(i,j) == largest_4_comp(1,4)
            fourth_comp(i,j) = f1(i,j);
        else
            biggest_comp(i,j) = 0;
            second_comp(i,j) = 0;
            second_comp(i,j) = 0;
            second_comp(i,j) = 0;
        end
    end
end

biggest_comp = uint8(biggest_comp);
second_comp = uint8(second_comp);
third_comp = uint8(third_comp);
fourth_comp = uint8(fourth_comp);

final_4 = biggest_comp + second_comp + third_comp + fourth_comp; 

final_4 = uint8(final_4);

% Here, four separate files are generated to display the four components
% separately. In case a single file is to be generated, the following code
% can be used:

% final_4 = flabel;
% 
% for i = 1:256
%     for j = 1:256
%         if final_4(i,j) == largest_4_comp(1,1) || ...
%                 final_4(i,j) == largest_4_comp(1,2) ||...
%                 final_4(i,j) == largest_4_comp(1,3) || ...
%                 final_4(i,j) == largest_4_comp(1,4)
%             final_4(i,j) = f1(i,j);
%         else
%             final_4(i,j) = 0;
%         end
%     end
% end


imwrite(biggest_comp,'biggest_component.gif');
imwrite(second_comp,'second_component.gif');
imwrite(third_comp,'third_component.gif');
imwrite(fourth_comp,'fourth_component.gif');

imwrite(final_4,'largest_4_components.gif');

end