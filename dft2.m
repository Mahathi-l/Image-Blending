function [fftImg] = dft2(img)
%     img = (img-min(img(:)))./(max(img(:))-min(img(:)));
    %approach 1 - operate fft on first dimension first and then the second
    %using the syntax fft(x, [], dim)
    [r c ch] = size(img);
    if ch>1
        fftImg(:,:,1) = fft(fft(img(:,:,1), [],1), [], 2);
        fftImg(:,:,2) = fft(fft(img(:,:,2), [],1), [], 2);
        fftImg(:,:,3) = fft(fft(img(:,:,3), [],1), [], 2);
    else
        fftImg = fft(fft(img, [],1), [], 2);
    end
end

