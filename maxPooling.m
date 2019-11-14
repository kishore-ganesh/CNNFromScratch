function [output] = maxPooling(input, poolingMatrix)
  xSize = size(poolingMatrix)(1);
  ySize = size(poolingMatrix)(2);
  inputSizeX = size(input)(1)
  inputSizeY = size(input)(2)
  %Check for odd
  % We can either pad or ignore
  %  Add stride to the function
  output = zeros(floor(inputSizeX/xSize), floor(inputSizeY/ySize));
  for x = 1:xSize:size(input)(1)
    for y = 1:ySize:size(input)(2)
      rangeXL = x;
      rangeXR = rangeXL + xSize - 1;
      rangeYL = y;
      rangeYR = rangeYL + ySize -1;
      output(floor(x/xSize)+1, floor(y/ySize)+1) = max(max(max(input(rangeXL:rangeXR, rangeYL:rangeYR))));            
    end
   end
end
