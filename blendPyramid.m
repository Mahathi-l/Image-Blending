function [blendedImg] = blendPyramid(bg, fg, bw_mask, nlayers)
    [~, lPyrBG] = ComputePyr(bg, nlayers); %calculate laplacian pyr of 1st img
    [~, lPyrFG] = ComputePyr(fg, nlayers); %calculate laplacian pyr of 2nd img
    [gPyrMask,~] = ComputePyr(double(bw_mask), nlayers); %gaussian pyr of mask
    for i = 1:length(gPyrMask)
        %calculate blended pyramid based on alpha blending with mask gpyr
        lblend{i} = (gPyrMask{i}) .* lPyrBG{i} + (1-(gPyrMask{i})).*lPyrFG{i};
    end
    layer = length(lblend);
    %generate gaussian kernel 
    dscale = 2.5; 
    sigm = (2*dscale)./6;
    kernS = floor(4*sigm+0.5);
    h = fspecial('gaussian', kernS ,sigm);
    %collapse pyramid 
    while(layer>1)
        lblend{layer-1} = convfreq(upscale(lblend{layer}, size(lblend{layer-1})),h)+lblend{layer-1};
        layer = layer-1;
    end
    blendedImg = lblend{1};
end

