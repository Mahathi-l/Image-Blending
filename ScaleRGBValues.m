function [opImage] = ScaleRGBValues(img)
%tweaked from Project2 for just scaling the image
    opImage = img;
    Opimgr = img(:,:,1);
    Opimgg = img(:,:,2);
    Opimgb = img(:,:,3);
    opImage(:,:,1) = (Opimgr-min(Opimgr(:)))./(max(Opimgr(:))-min(Opimgr(:)));
    opImage(:,:,2) = (Opimgg-min(Opimgg(:)))./(max(Opimgg(:))-min(Opimgg(:)));
    opImage(:,:,3) = (Opimgb-min(Opimgb(:)))./(max(Opimgb(:))-min(Opimgb(:)));
end

