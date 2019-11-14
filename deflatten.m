function [output] = deflatten(vector)
  size_vector = size(vector);
  s = size_vector(2);
  s = sqrt(s);
  output = [];
  for i = 1:s:size_vector(2)
    output = [output;vector(1, i:i+s-1)]; %What happened here
  end
end