function [ lines ] = LineDetect( non_text_connected_components )

    lines = non_text_connected_components([non_text_connected_components.Density] >= 0.9 && (non_text_connected_components.AspectRatio) <= 0.1);

end

