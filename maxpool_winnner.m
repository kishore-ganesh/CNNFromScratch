function output = maxpool_winnner(matrix,winner)
  size_matrix = size(matrix);
  xsize = size_matrix(1);
  ysize = size_matrix(2);
  zsize = size_matrix(3);
  output = zeros(xsize, ysize, zsize);
  for z = 1:zsize
    for y = 1:ysize
      for x = 1:xsize
        if (matrix(x, y,z) == winner)
          output(1) = x;
          output(2) = y;
          output(3) = z;
        end
       end
     end
   end
 end 

 %Fix if slow