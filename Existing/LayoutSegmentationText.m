function [ segmented_layout ] = LayoutSegmentationText( text_connected_components )
    % The text_connected_component should be an array 2 component arrays
    % where the first component of each array element is the image and
    % the second component is the array of whitespaces of that image
    segmented_layout = arrayfun(morph, text_connected_components);
end


