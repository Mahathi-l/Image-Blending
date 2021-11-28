function [gPyr,lPyr] = ComputePyr(img1, num_layers)
    layer = 1;
    dscale = 2.5; 
    sigm = (2*dscale)./6;
    kernS = floor(4*sigm+0.5);
    h = fspecial('gaussian', kernS ,sigm);
    gPyr{layer} = img1; 
    while(sum(size(gPyr{layer}))~=2 && layer<=num_layers)
        gPyr{layer+1} = convfreq(gPyr{layer}, h);
        gPyr{layer+1} = downscale(gPyr{layer+1},0.5);
        layer = layer+1;
    end
    lPyr{layer}=gPyr{layer};
    while layer>1
        lPyr{layer-1} = gPyr{layer-1}-convfreq(upscale(gPyr{layer},size(gPyr{layer-1})), h);
%         figure;
%         imshow(lPyr{layer});
        layer = layer-1;
    end
end

