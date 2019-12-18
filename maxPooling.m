function [output, winners] = maxPooling(input, poolingMatrix)
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
  winners = zeros(size(output, 1), size(output, 2), 3);
  for x = 1:xSize:input_size_matrix(1)
    for y = 1:ySize:input_size_matrix(2)
      rangeXL = x;
      rangeXR = rangeXL + xSize - 1;
      rangeYL = y;
      rangeYR = rangeYL + ySize -1;
      xIndex = floor(x/xSize)+1;
      yIndex = floor(y/ySize)+1;
      output(xIndex, yIndex) = max(max(max(input(rangeXL:rangeXR, rangeYL:rangeYR, :))));            
      winners(xIndex, yIndex, :) = maxpool_winnner(input, [rangeXL, rangeXR; rangeYL, rangeYR], output(xIndex, yIndex));
      if(winners(xIndex, yIndex, :) == [0, 0, 0])
          disp("Err")
      end
      
    end
   end
end
