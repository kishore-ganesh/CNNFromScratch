function [output] =maxpool_winnner(matrix,winner)
  size_matrix = size(matrix)
  xsize = size_matrix(1);
  ysize = size_matrix(2);
  zsize = size_matrix(3);
  for z = 0:zsize
    for y = 0:ysize
      for x = 0:xsize
        if (matrix(x, y,z) == winner)
          output(0) = x;
          output(1) = y;
          output(2) = z;
        end
       end
     end
   end
 end 

 %Fix if slow