function [output] = deflatten(vector)
  s = size(vector)(2);
  s = sqrt(s);
  output = [];
  for i = 1:s:size(vector)(2)
    output = [output;vector(1, i:i+s-1)]; %What happened here
  end
end