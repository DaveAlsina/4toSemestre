function [redChannel, greenChannel] = transformation1(blueChannel)

blueChannel = double(blueChannel)./256;
r = 1;

redChannel = r.*cos(blueChannel.*50);
greenChannel = r.*sin(blueChannel.*50);

redChannel = redChannel.*256; 
greenChannel = greenChannel.*256;

end

