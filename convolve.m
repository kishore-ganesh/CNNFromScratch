
function [output] = convolve(matrix, convolveMatrix)
  % Have to adjust for mutli dimension
  size_matrix = size(matrix);
  size_convolve_matrix = size(convolveMatrix);
  paddedSizeX = size_matrix(1)+size_convolve_matrix(1)-1;
  paddedSizeY = size_matrix(2)+size_convolve_matrix(2)-1;
  cSize = size_convolve_matrix(1);
  paddedMatrix = zeros(paddedSizeX, paddedSizeY, size(matrix, 3));
  offset = (size_convolve_matrix(1) - 1)/2;
  size_padded_matrix = size(paddedMatrix);
  paddedMatrix(1+offset:size_matrix(1)+offset, 1+offset:size_matrix(2)+offset, :) = matrix;
  output = zeros(size_matrix(1), size_matrix(2));
  for x=1:1:size_padded_matrix(1) - size_convolve_matrix(1) + 1
    for y = 1:1:size_padded_matrix(2) - size_convolve_matrix(2) + 1
      subMatrix = paddedMatrix(x:x+cSize-1, y:y+cSize-1);
      output(x, y) = sum(sum(sum(subMatrix.*convolveMatrix))); % Should be across all dimensions
    end
  end
end


