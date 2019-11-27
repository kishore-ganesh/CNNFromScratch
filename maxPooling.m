function [output] = maxPooling(input, poolingMatrix)
  size_matrix = size(poolingMatrix);
  xSize = size_matrix(1);
  ySize = size_matrix(2);
  input_size_matrix = size(input);
  inputSizeX = input_size_matrix(1);
  inputSizeY = input_size_matrix(2);
  %Check for odd
  % We can either pad or ignore
  %  Add stride to the function
  output = zeros(floor(inputSizeX/xSize), floor(inputSizeY/ySize));
  for x = 1:xSize:input_size_matrix(1)
    for y = 1:ySize:input_size_matrix(2)
      rangeXL = x;
      rangeXR = rangeXL + xSize - 1;
      rangeYL = y;
      rangeYR = rangeYL + ySize -1;
      output(floor(x/xSize)+1, floor(y/ySize)+1) = max(max(max(input(rangeXL:rangeXR, rangeYL:rangeYR))));            
    end
   end
end
