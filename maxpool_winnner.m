function output = maxpool_winnner(matrix,bounds, winner)
  zsize = size(matrix, 3);
  output = zeros(3, 1);
  for z = 1:zsize
    for y = bounds(2, 1):bounds(2,2)
      for x = bounds(1, 1):bounds(1, 2)
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
 
 %Make this take the filter and make it the filter dimensions