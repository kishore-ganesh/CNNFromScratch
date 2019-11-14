
function [output] = convolve(matrix, convolveMatrix)
  % Have to adjust for mutli dimension
  paddedSizeX = size(matrix)(1)+(size(convolveMatrix)(1)-1);
  paddedSizeY = size(matrix)(2)+(size(convolveMatrix)(2)-1);
  cSize = size(convolveMatrix)(1);
  paddedMatrix = zeros(paddedSizeX, paddedSizeY, size(matrix)(3));
  offset = (size(convolveMatrix)(1) - 1)/2;

  paddedMatrix(1+offset:size(matrix)(1)+offset, 1+offset:size(matrix)(2)+offset, :) = matrix;
  output = zeros(size(matrix)(1), size(matrix)(2));
  for x=1:1:size(paddedMatrix)(1) - size(convolveMatrix)(1) + 1;
    for y = 1:1:size(paddedMatrix)(2) - size(convolveMatrix)(2) + 1;
      subMatrix = paddedMatrix(x:x+cSize-1, y:y+cSize-1);
      output(x, y) = sum(sum(sum(subMatrix.*convolveMatrix))); % Should be across all dimensions
    end
  end
end


