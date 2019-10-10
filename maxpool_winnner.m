function [output] =maxpool_winnner(matrix,winner)
  xsize = size(matrix)(1)
  ysize = size(matrix)(2)
  zsize = size(matrix)(3)
  for z = 0:zsize
    for y = 0:ysize
      for x = 0:xsize
        if (matrix(x)(y)(Z) == winner)
          output(0) = x
          output(1) = y
          output(2) = z
        end
       end
      end
     end
 end 
