
function[] = Stalk_Analyzer()
 try 
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Where to put the results
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %OutPath = inputdlg('Please enter the name of the folder you want to save to: '); % , 'mainPath'
        
        %OutPath = OutPath{:} ; % opsyswitch(OutPath{:});  THIS IS NEEDED IF USERINPUT IS TURNED ON!
        
        %mkdir(OutPath); 
        %O.OutPath = OutPath;
        O.fileName = [];
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Where to find all scanner images -> makes a list!
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        FilePath = inputdlg('Please enter the name of the folder you want to load from : ' );
        FilePath = ( strcat( FilePath, '\' ) );
        FilePath = (FilePath{:}); % THIS IS NEEDED IF USERINPUT IS TURNED ON!
        % FilePath = opsyswitch(FilePath);
        dirList = dir(FilePath);                                            % dir directory_name lists the files in a directory.
        FileExt = {'tif','TIF','tiff','TIFF','bmp','BMP','gif','GIF'}; %, 'jpg', 'JPG'};
        verbose = 0;
        ridx = strcmp({dirList.name},'.') | strcmp({dirList.name},'..') | strcmp({dirList.name},'.DS_Store') | strcmp({dirList.name},'dd') | strcmp({dirList.name},'test');
        dirList(ridx) = [];  % | :=  Logical or.  strcmp Compare strings. ==> kick out the empty files
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if size(dirList,2) ~= 0
        fileList = sdig(FilePath,{},FileExt,verbose);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        OutPath = ( strcat( FilePath, 'results\' ) ); % OutPath = ( strcat( FilePath, '\', 'results\' ) );
        mkdir ( OutPath );
        mkdir ( [OutPath 'Bundles\'] );
        O.OutPath = OutPath;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        y = numel(fileList{1}); 
        
for a  = 1 : y                   % start of loop 1 ("load the whole image")
           
            rgb0 = imread(fileList{1}{a});      % load the whole image
            O.fileName = fileList{1}{a};        
% To analyse parts of the image, redo the outcommenting:
for b = 1:4           % start of loop 2 ("proccess the parts of the image")

            if b == 1
                rgb = imcrop(rgb0, [0, 0, 2500, 1900]); %figure; imshow(rgb);
                r = 'B';
            elseif b == 2
                rgb = imcrop(rgb0, [0, 1900, 2500, 3800]); %figure; imshow(rgb);
                r = 'D';
            elseif b == 3
                rgb = imcrop(rgb0, [2500, 0, 5000, 1900]); %figure; imshow(rgb);
                r = 'A';
            elseif b == 4
                rgb = imcrop(rgb0, [2500, 1900, 5000, 3800]); %figure; imshow(rgb);
                r = 'C';
            end

                % figure; imshow(rgb,[]);
                [pth,nm1,ext] = fileparts(fileList{1}{a});
                ofs1 = [OutPath nm1 '-' r '.tif']; % ofs1 = [OutPath nm1 '-' r  '.tif'];
                
                Im = figure; 
                imshow(rgb,[]); % imshow(rgb0,[]);
                
                hold on;        
                
                Im = imresize(Im,.25);
                hold off;
                fid2 = fopen(ofs1, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im,ofs1,'tif');
                   fclose(fid2);
                end
                %saveas (Im,ofs1,'tif'); % imwrite( Im,ofs1 );

                Te = im2bw(rgb, graythresh(rgb)/1.5); % After cropping, convert the image from color to grayscale
                labeledImage = bwlabel(Te, 8); % Label each blob
                coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels

                figure, imagesc(coloredLabels), title('Pseudo colored labels');

                blobMeasurements = regionprops(labeledImage, 'all'); % Get all the blob properties.
                % Get a list of the areas.
                area_values = [blobMeasurements.Area]; % Area of all identified blobs
                excentic = [blobMeasurements.Eccentricity]; % Eccentricity of all identified blobs
                
                indexes_are = find(15000 <= area_values); % Exclude blobs that are too small
                indexes_exc = find(excentic < 0.99); % Exclude blobs that are too exxcentric
                spotsOnlyImage = (ismember(labeledImage, indexes_are) & ( ismember(labeledImage, indexes_exc)) ); 
                % Show all remaining blobs
                figure, imshow(spotsOnlyImage, []); % , title('Spots-only image');
                Tb = spotsOnlyImage;
                ofs10 = [OutPath nm1 '-' r ' - spots' '.tif']; % ofs10 = [OutPath nm1 '-' r ' - spots' '.tif'];

                Im = figure; 
                imshow(Tb,[]);
                % title('Spots-only image');
                hold on;        
                
                Im = imresize(Im,.25);
                hold off;
                
                % saveas (Im,ofs10,'tif'); 
                fid2 = fopen( ofs10, 'w+' ); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im, ofs10, 'tif');  
                   % imwrite( Im, ofs10 ); 
                   fclose(fid2);
                end
                
                s = regionprops(spotsOnlyImage, 'all');
                % figure; imshow(rgb0,[]); % imshow(rgb,[]); 
                hold on;
                for f = 1 : numel(s) % 2  : numel(s) % 
                    scatter(s(f).Centroid(:,1), s(f).Centroid(:,2), 'r*')
                    h = imrect(gca, s(f).BoundingBox);
                    addNewPositionCallback(h,@(p) title(mat2str(p,3)));
                    fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
                    setPositionConstraintFcn(h,fcn);
                   
                end
                hold off;
               

        
        info = questdlg('Would you like to crop yourself?', 'Auto cropping?', 'Yes', 'No', 'Yes!');
                % Handle response
                switch info
                    case 'Yes'
                        
        wind = inputdlg('Please enter the number of stalks you want to analyse: ' );
        weiter = str2double(wind{:});
        
 for c = 1 : weiter % numel(s)
    
     numovascbundles = 0;
    
    
     Ic = imcrop(rgb); % figure, imshow(Ic), title('cropped image');

     [pth,nm1,ext] = fileparts(fileList{1}{a});
                ofs2 = [OutPath nm1 '-' r '-' num2str(c)   '.tif'];
 
                Im = figure; 
                imshow(Ic), title('cropped image');
                
                hold on;        
                
                Im = imresize(Im,.25);
                hold off;
                fid2 = fopen(ofs2, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im,ofs2,'tif');
                    fclose(fid2);
                end
                

I0 = im2double(Ic); % (entropyfilt(Ic(:,:,1)) + entropyfilt(Ic(:,:,2)) + entropyfilt(Ic(:,:,3))); % im2double(rgb);
    
G = imfilter(I0(:,:,2), fspecial('gaussian', 6, 3)); 
p = 1; 
figure, imshow (rgb, [], 'InitialMagnification', 2000);
for q = 0.5 : 0.5 : 4
    F = G > graythresh(G) / q;
    
    % figure; 
    subplot(2, 4, p);
    imshow(Ic, [], 'InitialMagnification', 2000);
    hold on;
    himage = imshow(F);
    set(himage, 'AlphaData', 0.5);
    title([ num2str(q) ' times the Otsu graythresh'])
    axis tight;
    axis off;
    p = p + 1;
end

totalareathresh = inputdlg('Please tell me which graythresh describes the outline of the whole stalk best' );
totalthresh = str2num(totalareathresh{:}); % Let the user pick which threshold best finds the whole stalk
F = G > graythresh(G) / totalthresh; % Divide the Otsu threshold through the user defined factor to best determine the stalk
    close;

   % [pth,nm1,ext] = fileparts(fileList{1}{a});
    ofs3 = [OutPath nm1 '-' r '-' num2str(c) '- whole stalk.tif'];
    Im = figure; 
    imshow(Ic, []); % , 'InitialMagnification', 2000); 
    title('Area of the entire stalk');
    hold on;
    %himage = imshow(F);
    %set(himage, 'AlphaData', 0.5);
    boundaries = bwboundaries(F); % Determine the outer boundaries of the image containing the whole stalk
   
    [max_size, max_index] = max(cellfun('size', boundaries, 1)); % Identify the longest of all determined boundaries 
    blobBoundary = boundaries{ max_index }; % The longest boundary is the most likely to be the stalk
    plot(blobBoundary(:,2), blobBoundary(:,1), 'r-', 'LineWidth', 2);

    hold off;
    % pause(5);
    Im = imresize(Im,.25);
    fid2 = fopen(ofs3, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im,ofs3,'tif');
                   fclose(fid2);
                end

labeledImage_all = bwlabel(F, 8);

blobMeasurements_all = regionprops(labeledImage_all, 'all'); % Get all the blob properties.
area_value_stalk = [blobMeasurements_all.Area];
area_value_stalk = max(area_value_stalk);

Q = (I0(:,:,1) .* I0(:,:,2) .* I0(:,:,3)); 
%%%%%%%%%

info = questdlg('Would you like to measure the stalk`s extensions?', 'Length and Width?', 'Yes!', 'No.', 'Yes!');
                % Handle response
                switch info
                    case 'Yes!'
                            Ibw = labeledImage_all;

                            %%% Calculate axis and draw

                            [M N] = size(Ibw);
                            [X Y] = meshgrid(1:N,1:M);

                            %Mass and mass center
                            m = sum(sum(Ibw));
                            x0 = sum(sum(Ibw.*X))/m;
                            y0 = sum(sum(Ibw.*Y))/m;

                            %Covariance matrix elements
                            Mxx = sum(sum((X-x0).^2.*Ibw))/m;
                            Myy = sum(sum((Y-y0).^2.*Ibw))/m;
                            Mxy = sum(sum((Y-y0).*(X-x0).*Ibw))/m;

                            MM = [Mxx Mxy; Mxy Myy];

                            [U S V] = svd(MM);

                            W = V(:,1)/sign(V(1,1)); %Extremal directions (normalized to have first coordinate positive)
                            H = V(:,2);
                            W = 2*sqrt(S(1,1))*W; %Scaling of extremal directions to give ellipsis half axis
                            H = 2*sqrt(S(2,2))*H;

                            figure; imshow(Ibw);

                            hold on;  
                            ctr = blobMeasurements_all.Centroid;
                            theta = blobMeasurements_all.Orientation;
                            
                            hold on
                                plot(x0,y0,'b*');
                                 plot(x0,y0,'bo');
                                quiver(x0,y0,W(1),H(1),'r', 'lineWidth', 3)
                                quiver(x0,y0,W(2),H(2),'g', 'lineWidth', 1)
                            hold off

                             pause( 2 );
                             close;
                            long_axis_stalk = 0;
                            short_axis_stalk = 0;
                            % long_axis_stalk = blobMeasurements_all.MajorAxisLength;
                            % short_axis_stalk = blobMeasurements_all.MinorAxisLength;
                            LONG_AXIS = regionprops(labeledImage_all, 'MajorAxisLength'); 
                            maxVals = arrayfun(@(struct)max(struct.MajorAxisLength(:)),LONG_AXIS);
                            long_axis_stalk = max(maxVals(:));

                            SMALL_AXIS = regionprops(labeledImage_all, 'MinorAxisLength'); 
                            minVals = arrayfun(@(struct)max(struct.MinorAxisLength(:)),SMALL_AXIS);
                            short_axis_stalk = max(minVals(:));
                            
                    case 'No.'
                            long_axis_stalk = 0;
                            short_axis_stalk = 0;
                end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 1; 
figure, imshow (rgb, [], 'InitialMagnification', 2000);
for q = 0 : 0.3 : 2.1
    H = Q > (graythresh(Q) / q);
    %H = ((I0(:,:,1) .* I0(:,:,2) .* I0(:,:,3)) > 0.1); 
    H = imfilter(H, fspecial( 'gaussian', 10, 10 ) ); % figure; imshow(H); % inner parts of the stalk 
    % figure; 
    subplot(2, 4, p);
    imshow(Ic, [], 'InitialMagnification', 2000);
    hold on;
    himage = imshow(H);
    set(himage, 'AlphaData', 0.5);
    title([ num2str(q) ' times the Otsu graythresh'])
    axis tight;
    axis off;
    p = p + 1;
end

totalinsidethresh = inputdlg('Please tell me which graythresh describes the outline of the pith best' );
insidethresh = str2num(totalinsidethresh{:});
H = Q > graythresh(Q) / insidethresh;
    close;
   
labeledImage_inside = bwlabel(H, 8);

blobMeasurements_inside = regionprops(labeledImage_inside, 'all'); % Get all the blob properties.
area_value_inside_a = [blobMeasurements_inside.Area];
biggestBlobIndex = find(area_value_inside_a == max(area_value_inside_a));
keeperBlobsImage = ismember(labeledImage_inside, biggestBlobIndex);

keeperBlobsImage_close = imclose(keeperBlobsImage, strel('disk', 10)); % figure; imshow(keeperBlobsImage_open); 

    ofs4 = [OutPath nm1 '-' r '-' num2str(c) '- pith.tif'];
    Im_pith = figure;
imshow(I0, []);
hold on; % Prevent plot() from blowing away the image.
title('Original Color Image with Pith Outlined');
% Get its boundary and overlay it over the original image.
boundaries = bwboundaries(keeperBlobsImage_close);
% blobBoundary = boundaries{1};
 [max_size, max_index] = max(cellfun('size', boundaries, 1));
 blobBoundary = boundaries{ max_index };
plot(blobBoundary(:,2), blobBoundary(:,1), 'r-', 'LineWidth', 2);
hold off;
    Im_pith = imresize(Im_pith,.25);
     fid2 = fopen(ofs4, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im_pith,ofs4,'tif');
                   fclose(fid2);
                end
                
    % pause(5);
area_value_inside_b = regionprops(keeperBlobsImage_close, 'all');
area_value_inside_c = [area_value_inside_b.Area];
area_value_inside = area_value_inside_c; % find(area_value_inside_c == max(area_value_inside_c));
%length_value_inside = [blobMeasurements_inside.MajorAxisLength] % ;
%minlength_value_inside = [blobMeasurements_inside.MinorAxisLength] % ;
area_value_rind = area_value_stalk - area_value_inside;
percent_inside = area_value_inside * (100 / area_value_stalk);

%%%%
Wb = bwboundaries(F);
Ib = bwboundaries(keeperBlobsImage_close); % (H);
W = 0;
% figure;
for i = 1:size(Wb{1},1)
    delta = bsxfun(@minus,Ib{1},Wb{1}(i,:));
    dist = sum(delta.*delta,2).^.5;
    if min(dist) > 10
        [W(i) idx] = min(dist);
    else
        W(i) = 0;
    end
    
end
    figure;plot(W);
    % MW = mean(W);
    
    MW = 0;
    Idx = find(W(:) ~= 0);
    nIdx = numel(Idx);
    for i = 1:size(W,2)
        if W(i) ~= 0
            MW = (MW + W(i));
        else 
            MW = MW;
        end
    end
    MW = MW / nIdx;

%%%%
 I2 = rgb2gray(I0) ; % figure; imshow(I2); % / max(max(I0));
 % I2 = imdilate(I2, strel('disk', 7)); % figure; imshow(I2); 3 works good!
 for n = 0.1 : 0.1 : 1
     if n == 0.1
 bI = ~(imadjust(I2 - (graythresh(I2) / 1.5)) > n); %figure, imshow(bI,[]), title('binarised image'); % if im2double was used
     else
 bI = bI - ~(imadjust((I2 - (graythresh(I2) / 1.5))) > n) ; % figure, imshow(bI,[]), title('binarised image'); % if im2double was used
     end
 end
 
 % bI = imadjust(I2);
 % figure, imshow(bI,[]), title('image before binarisation');
 bI = abs(bI); % figure, imshow(bI,[]), title('image before binarisation');
 G = fspecial('gaussian', [8 8], 8); G = G * 10000; [n, m] = size(bI); 
 % G = fspecial('gaussian', [round(position(3)/2) round(position(4)/2)], round(position(3)/4)); G = G * 10000; [n, m] = size(bI); 
 F2 = real(ifft2(fft2(bI) .* fft2(rot90(G), n, m))); 
 % figure; imshow(F2, []); %, 'InitialMagnification', 'fit');
 A = F2 / max(max(F2));
 B = A > 0.18; % figure; imshow(B);
 % sig = round(position(4)/2); 
 sig = 20;
 bImask = imfilter(bI,fspecial('gaussian',[2*sig 2*sig],sig),'replicate'); 
 %bImask = ~(bImask); bImask = (bImask / max(max(bImask))); 
 bImask = abs(bImask);
 bImaska = bImask > 5;
 bImask = ~bImaska;
 % figure, imshow(bImask,[]), title('binarised mask');
 
 bIabs = abs(bI); % figure, imshow(bIabs,[]);
 bItry = bIabs / max(max(bIabs)); % normalize the image to 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Filtering using anisotropic diffusion
 % from www.csse.uwa.edu.au/~pk/Research/MatlabFns/Spacial/anisodiff.m
     im = bItry;
     [rows,cols] = size(im);
     diff = im;
     niter = 130; % 70; works good
     kappa = 0.2; % 40; works good!
     lambda = 0.16;
     option = 2;
    for i = 1:niter
    %  fprintf('\rIteration %d',i);

      % Construct diffl which is the same as diff but
      % has an extra padding of zeros around it.
      diffl = zeros(rows+2, cols+2);
      diffl(2:rows+1, 2:cols+1) = diff;

      % North, South, East and West differences
      deltaN = diffl(1:rows,2:cols+1)   - diff;
      deltaS = diffl(3:rows+2,2:cols+1) - diff;
      deltaE = diffl(2:rows+1,3:cols+2) - diff;
      deltaW = diffl(2:rows+1,1:cols)   - diff;

      % Conduction

      if option == 1
        cN = exp(-(deltaN/kappa).^2);
        cS = exp(-(deltaS/kappa).^2);
        cE = exp(-(deltaE/kappa).^2);
        cW = exp(-(deltaW/kappa).^2);
      elseif option == 2
        cN = 1./(1 + (deltaN/kappa).^2);
        cS = 1./(1 + (deltaS/kappa).^2);
        cE = 1./(1 + (deltaE/kappa).^2);
        cW = 1./(1 + (deltaW/kappa).^2);
      end

      diff = diff + lambda*(cN.*deltaN + cS.*deltaS + cE.*deltaE + cW.*deltaW);

    end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 bItry = diff; % imadjust(diff); 
 %figure, imshow(bItry), title('after adjusting the contrast');
 
 D = imregionalmax(bItry); figure; imshow(D);
 E = H & B & D; % & bImask
 % figure; imshow(E);
 K = F & ~keeperBlobsImage_close; % H; % figure; imshow(K);
 % close all; %%%%%%%%%%%%%%%%%%%%%%%%%% REMOVE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 figure; imshow(Ic); % imshow(rgb2gray(I0));
 hold on;
 plot(blobBoundary(:,2), blobBoundary(:,1), 'b-', 'LineWidth', 1);
 %himage = imshow(E);
 %set(himage, 'AlphaData', 0.5);
 title('Pith outline and found vascular bundles superimposed on original image');
 samp = find(E);
 [samp1, samp2] = find(E == 1);
 Z = [samp1, samp2];

 scatter (Z(:,2), Z(:,1) , 'r.');
 % hold off;
 info = questdlg('Would you like to add some more peaks to the found ones', 'Less peaks found than actually there?', 'Yes!', 'No.', 'Yes!');
                % Handle response
                switch info
                    case 'Yes!'
                        lint = inputdlg('Please enter the number of bundles you want to add: ' );
                        l = str2num(lint{:});
                        [T1, T2] = ginput(l);
                        pos_x = round(T1); 
                        pos_y = round(T2);
                        % pos = [pos_x, pos_y];
                        pos = [pos_y, pos_x];
                        Z = [Z; pos];
                        scatter (Z(:,2), Z(:,1) , 'r.');
                        scatter(pos(:,2), pos(:,1) , 'bo');
                        % pause(5);
                        info = questdlg(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk'], 'Number of vascular bundles', 'OK!', 'OK!');
                        numovascbundles = numel(Z(:,1)); % numovascbundles = numel(samp) + numel(pos,1);
                        switch info
                            case 'OK!'
                                disp([info ':  So far so good.'])
                        end
                    case 'No.'
                        info = questdlg(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk'], 'Number of vascular bundles', 'OK!', 'OK!');
                        % Handle response
                        switch info
                            case 'OK!'
                                disp([info ':  So far so good.'])
                                 numovascbundles = numel(Z(:,1)); % numovascbundles = numel(samp);
                        end
                end
 
 
 area_value_inside = area_value_inside / (316)^2; 
 bundle_density = numovascbundles / area_value_inside;
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    hold off;
 
info = questdlg(['Would you like to keep these results or would you like to retry with a new crop box? '], 'Carry on?',  'Carry on!', 'One more try',  'Carry on!');
                % Handle response
                switch info
                     case 'One more try'
                             disp([info ':  Now comes trial # 2 '])
                          [percent_inside, MW, Z, area_value_stalk, area_value_inside, area_value_rind, numovascbundles, bundle_density ] = drier_piece(rgb, OutPath, nm1, r, c);
                          percent_inside = area_value_inside * (100 / area_value_stalk);  
                          info = questdlg('Would you like to keep these results or would you like to retry with a new crop box? ', 'Carry on?',  'Carry on!', 'One more try',  'Carry on!');
                                % Handle response
                                switch info
                                     case 'One more try'
                                          disp([info ':  Now comes trial # 3 '])
                                          [ percent_inside, MW, Z, area_value_stalk, area_value_inside, area_value_rind, numovascbundles, bundle_density ] = drier_piece(rgb, OutPath, nm1, r, c)
                                          %percent_inside = area_value_inside * (100 / area_value_stalk);  
                                          info = questdlg('Would you like to keep these results or would you like to retry with a new crop box? ', 'Carry on?',  'Carry on!', 'One more try',  'Carry on!');
                                                % Handle response
                                                switch info
                                                     case 'One more try'
                                                             disp([info ':  Now comes trial # 4 '])
                                                          [ percent_inside, MW, Z, area_value_stalk, area_value_inside, area_value_rind, numovascbundles, bundle_density ] = drier_piece(rgb, OutPath, nm1, r, c)
                                                            %percent_inside = area_value_inside * (100 / area_value_stalk);
                                                            info = questdlg('That was your last try with this stalk. If you want to try again, please start the program again.', 'OK',  'OK!');
                                                                % Handle response
                                                                switch info
                                                                    case 'OK'
                                                                        disp([info ':  OK, than let us look at the indivdual vascular bundles. This was stalk # ' num2str(c) ' . '])
                                                                end
                                                        %disp([info ':  OK, than let us look at the next stalk. This was stalk # ' num2str(c) ' . '])
                                                end     
                                     case 'Carry on!'
                                        disp([info ':  OK, than let us look at the indivdual vascular bundles. This was stalk # ' num2str(weiter) ' . '])
                                end     
                     case 'Carry on!'
                        disp([info ':  OK, than let us look at the indivdual vascular bundles. This was stalk # ' num2str(c) ' . '])
                end                
          
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ofs5 = [OutPath nm1 '-' r '-' num2str(c) '- counted bundles.tif'];
    Im = figure;
    imshow(Ic);
    hold on;
    scatter (Z(:,2), Z(:,1) , 'r.');
    title(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk']);
    hold off; 
    Im = imresize(Im,.25);
     fid2 = fopen(ofs5, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im,ofs5,'tif');
                   fclose(fid2);
                end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    ofs7 = [OutPath nm1 '-' r '-' num2str(c) '- counts outlined.tif'];
    Im7 = figure;
    imshow(Ic);
    hold on;
    scatter (Z(:,2), Z(:,1) , 'r.');
    title(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk']);
    plot(blobBoundary(:,2), blobBoundary(:,1), 'b-', 'LineWidth', 1); 
    title('Pith outline and found vascular bundles superimposed on original image');
    hold off; 
    Im7 = imresize(Im7,.25);
     fid2 = fopen(ofs7, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im7,ofs7,'tif');
                   fclose(fid2);
                end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [pth,nm1,ext] = fileparts(fileList{1}{a}); % (O.fileName);
    fclose('all');
    %outfile = [area_value_stalk, area_value_inside, area_value_rind, length_value_stalk, length_value_inside, length_value_rind, minlength_value_stalk, minlength_value_inside, minlength_value_rind,  numovascbundles, bundle_density];
    long_axis_stalk = long_axis_stalk/316;
    short_axis_stalk = short_axis_stalk/316; 
    MW = MW / 316;
    Zhelp = (numel(Z))/2;
    success_rate = 100 - ( (100/Zhelp)*l ); 
    % area_value_inside = area_value_inside / (316.6)^2; 
    % bundle_density = bundle_density / (316.6)^2; 
    outfile = [MW, area_value_inside, percent_inside, numovascbundles, bundle_density, long_axis_stalk, short_axis_stalk]; % , l, success_rate ];
    % output2 = [O.OutPath{2} nm '-' num2str(s) '-' num2str(p) '.xls'];
    % output = [OutPath '-' nm1 '-' num2str(a) '-' num2str(c) '-rindthickness-pitharea-percentpith-numobundles.xls'];
    output = [OutPath  nm1 '-' r '-' num2str(c) '-rindthickness-pitharea-percentpith-numobundles-bundledens-longaxis-shortaxis.xls'];
    fid2 = fopen(output, 'w+'); % ('output.txt','w');
    if fid2 >= 0
        % xlswrite( output,outfile); % , '-append', 'newline', 'unix', 'delimiter','\t');
        csvwrite( output,outfile);
        fclose(fid2);
    end
    
   
    close all; 
    
    Igreen = Ic (:,:,2); % = Ic(:,:,3) .* ( (abs( 255 - (imadjust(Ic(:,:,2) - (Ic(:,:,1)))))) /255 ); % 
    
    %%% Determine the size of the bundles
    for k = 1 : size(Z,1) % 10 %
    
    h = 15; % 15;
    w = 15; % 15;
    brala = size(Ic);
    if (round(Z(k,1)- h) > 0  && round(Z(k,2)- w) > 0 && round(Z(k,1)+ h) < brala(1) && round(Z(k,2)+ w) < brala(2))
    % Ishow = Ic((abs( round(Z(k,1)) - h ) ) : abs( round(Z(k,1))+ h) , abs( (round(Z(k,2))- w ) ) : abs( round(Z(k,2)) + w), :);
    % Ifit = Igreen((abs(round(Z(k,1)) - h ) ) : abs( round(Z(k,1))+ h) , abs( (round(Z(k,2))- w ) ) : abs( round(Z(k,2)) + w) , :);
    Ishow = Ic(( round(Z(k,1)) - h  ) :  (round(Z(k,1))+ h) , (round(Z(k,2))- w  ) : ( round(Z(k,2)) + w), :);
    Ifit = Igreen(((round(Z(k,1)) - h ) ) : ( round(Z(k,1))+ h) , ( (round(Z(k,2))- w ) ) : ( round(Z(k,2)) + w) , :);
    
    %%%%%
    ImZ = figure;           % Start a new figure to show the plots
    
   
    %%%%%
    subplot(2, 3, 1);
    Ione = cat(3, (Ishow(:,:,1))', (Ishow(:,:,2))', (Ishow(:,:,3))' );
    imshow(Ione, []);
   
    %%%
    % http://blogs.mathworks.com/steve/2013/06/25/homomorphic-filtering-part-1/
    %%%
    Ifitadd = im2double(Ifit);
    Ifitadd = log(1 + Ifitadd);
    sigma = 10; % 20; % MAY BE TOO BIG!!!!!
    M_HP = 2*size(Ifitadd,1) + 1;
    N_HP = 2*size(Ifitadd,2) + 1;
    [ X, Y ] = meshgrid( 1 : N_HP, 1 : M_HP );
    centerX = ceil(N_HP/2);
    centerY = ceil(M_HP/2);
    gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
    H_HP = exp(-gaussianNumerator./(2*sigma.^2));
    H_HP = 1 - H_HP;
    %imshow(H_HP,'InitialMagnification',25);
    
    If = fft2(Ifitadd, M_HP, N_HP);
    Iout = real(ifft2(H_HP.*If));
    Iout = Iout( 1 : size( Ifitadd, 1 ), 1 : size( Ifitadd, 2 ) );
    Ihmf_2 = exp(Iout) - 1;
    %imshow(Ihmf_2, []);
    filterRadius = sigma;
    filterSize = 2*filterRadius + 1;
    hLowpass = fspecial('average', filterSize);
    hImpulse = zeros(filterSize);
    hImpulse( filterRadius+1, filterRadius+1 ) = 1;
    hHighpass = hImpulse - hLowpass;
    Ihmf_spatial = imfilter(Ihmf_2', hHighpass, 'replicate');
    % Ihmf_spatial = imfilter(Ifitadd, hHighpass, 'replicate');
    Ihmf_spatial = exp(Ihmf_spatial) - 1;
    % imshow(Ihmf_spatial, []);
    %%%
    % http://blogs.mathworks.com/steve/2013/07/10/homomorphic-filtering-part-2/
    %%%
   
    M =  Ihmf_spatial < -( graythresh( Ihmf_spatial ) );
   
    M = bwareaopen(M, 25);
    X = [0, 0];
    o = 1;
    for m = 1 : size(Ifit,1) % for m = 1 : size(Ifit,1)
        for n = 1 : size(Ifit,1) % for n = 1 : size(Ifit,1)
            if (M(m,n) == 1)
                X(o,1) = m;
                X(o,2) = n;
                o = o + 1;
            else
                ;
            end
        end
    end
   
     %%%%%
     if  numel(X(:,2))== numel(X(:,1))
         
    subplot(2, 3, 2);       % Show the original unchanged b&w image
    imshow(Ifit',[]);
    title([num2str(c) '-' num2str(niter) ', Bundle # ' num2str(k) ]); %  num2str(kappa) '-' num2str(niter) ', Bundle # ' num2str(k) ]);
    
    %%%%%
    subplot(2, 3, 4);       % Show the distribution of brightnesses along the mean in x direction
    
    xProfile = mean(Ifit);  % Average over all lines in x direction
    xx = linspace(-(numel(xProfile)/2), (numel(xProfile)/2), numel(xProfile));
    plot(xx, xProfile);     % Show the average over all lines in x direction
    title('horizontal profile');
    axis tight;
    
    xac = xcov(xProfile);                       %unbiased autocorrelation
    xac = xac - min(xac);                       % normalize autocorrelation to 0 
    xxx = linspace(-(numel(xac)/2), (numel(xac)/2), numel(xac));
    
    xnormal = abs(max(max(xProfile)));
    %xnormal = max(max(xProfile)); % for scaling of the autocorrelation to show it on the picture
    if xnormal > 0
    
    A = find(floor(xac)==0);
    if numel (A) > 2
        
        for blubberbert = 1 : numel (xac)
            if blubberbert < A(ceil((numel(A))/2))
                xac(blubberbert) = 0;
            elseif blubberbert > A(ceil(((numel(A))/2)+1))
                xac(blubberbert) = 0;
            end
        end
        
    else
        %{
        for blubberbert = 1 : numel (xac)
        xac(blubberbert) = 0;
        end
        %}
        for blubberbert = 1 : numel (xac)
            if blubberbert < A(1)
                xac(blubberbert) = 0;
            elseif (numel(A)>1 && blubberbert >= A(2))
                xac(blubberbert) = 0;
            end
        end
        %{
        %}
    end
    xac = (xac /(max(max(xac)))) * xnormal;
    
    %%%%%
    subplot(2, 3, 5);       % Show the distribution of brightnesses along the mean in y direction
    
    yProfile = mean(Ifit'); % Average over all lines in y direction
    yx = linspace(-(numel(yProfile)/2), (numel(yProfile)/2), numel(yProfile));
    plot(yx, yProfile); 	% Show the average over all lines in y direction
    title('vertical profile');
    axis tight
    
    ynormal = max(max(yProfile)); % for scaling of the autocorrelation to show it on the picture
    yac = xcov(yProfile);                        %unbiased autocorrelation
    yac = yac - min(yac);
    xx = linspace(-(numel(yac)/2), (numel(yac)/2), numel(yac));
    
    B = find(floor(yac)==0);
    if numel (B) > 2
        
        for blubberbert = 1 : numel (yac)
            if blubberbert < B(ceil((numel(B))/2))
                yac(blubberbert) = 0;
            elseif blubberbert > B(ceil(((numel(B))/2)+1))
                yac(blubberbert) = 0;
            end
        end
    else
        
        for blubberbert = 1 : numel (yac)
            if blubberbert < B(1)
                yac(blubberbert) = 0;
            elseif (numel(B)>1 && blubberbert >= B(2)) % blubberbert >= B(2)
                yac(blubberbert) = 0;
            end
        end
        %{
        %}
    end
    yac = (yac /(max(max(yac)))) * ynormal;
    % plot(xxx, yac);
    axis tight;
    hold on;
    
    %%%%%
    subplot(2, 3, 3);   % Show the original unchanged b&w image with the results of the autocorrelation 
    Imshow = cat(3, (Ishow(:,:,1))', (Ishow(:,:,2))', (Ishow(:,:,3))' );
    imshow(Imshow,[]);% imshow(Ishow,[]); % imshow(M); %
   
    %%%%%%
    if numel (X) < 2 || ( X(1) == 0 && X(2) == 0 ) 
        subplot(2, 3, 6); % subplot(2, 3, 4);
        plot(X(:,1), X(:,2), 'b.');
        text(1, 1000, 'Image can not be analysed', 'fontsize', 7);
        subplot(2, 3, 6); % subplot(2, 3, 5);
        plot(X(:,1), X(:,2), 'b.');
        text(1, 1000, 'Image can not be analysed', 'fontsize', 7);
        brara = [1, 1 ; 1, 1];
        close all;
      
    else   
        Imshow = cat(3, (Ishow(:,:,1))', (Ishow(:,:,2))', (Ishow(:,:,3))' );
        imshow(Imshow,[]);% imshow(Ifit',[]);
        options = statset('Display','final');
        if (numel(X(:,2)) > 20 & numel(X(:,1)) > 20 )
            obj = gmdistribution.fit(X,1,'Options',options);
            hold on
            %ezcontour(@(x,y)pdf(obj,[x y]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            ezcontour(@(x,y)pdf(obj,[y x]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            
            hold off
            ComponentMeans = obj.mu;
            ComponentCovariances = obj.Sigma;
            MixtureProportions = obj.PComponents;

            %%%%%
            subplot(2, 3, 6);   % Show the vascular bundle as a cloud of scattered spots 
            %%%% neu
           
            scatter((X(:,2)), (X(:,1)), 'k.'); axis([0 size(Ifit,1) 0 size(Ifit,1)]);
            hold on
            %ezcontour(@(x,y)pdf(obj,[x y]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            ezcontour(@(x,y)pdf(obj,[y x]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            % h = ezcontour(@(x,y)pdf(obj,[x y]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            t = findall(gcf,'type','text');
            % delete the text objects
            delete(t);
            hold off
            brara = sqrt(obj.Sigma);
       
    %end % end the if statement in line 1293( if numel (X) > 2)
    %%%%%
    %if (numel(A) > 1 & numel(B) >1 && brara(1) - brara(4) > 1 && brara(1) < 11 ) % && brara(4) < 5 )
    if  min(min(Ihmf_spatial)) < -0.04
         if  brara( 1, 1 ) > brara( 2, 2 ) 
            Awert = brara( 1, 1 );
            Bwert = brara( 2, 2 );
        else
            Awert = brara( 2, 2 );
            Bwert = brara( 1, 1 );
        end
        Cwert = ( Awert / Bwert );
        if Cwert < 2
            %%%%%%
            % brara = sqrt(obj.Sigma);
            % outfile =  [brara(1,1)*((316.6)^.5), brara(2,2)*((316.6)^.5), (pi*brara(1,1)*brara(2,2)/ 316.6)]; % ComponentCovariances(:)';

            outfile =  [brara(1,1)/(316), brara(2,2)/(316), (pi*brara(1,1)*brara(2,2)/(316*316))];
            output = [ OutPath 'Bundles\' nm1 '-' r '-' num2str(c) '-' num2str(niter) '-'  num2str(k) '-bund_size.xls' ]; % num2str(kappa) '-' num2str(k) '-bund_size.xls'];
            fid2 = fopen(output, 'w+'); % ('output.txt','w');
            if fid2 >= 0
                csvwrite( output,outfile );
                % xlswrite( output,outfile); % , '-append', 'newline', 'unix', 'delimiter','\t');
                fclose( fid2 );
            end

            ofs6 = [OutPath 'Bundles\' nm1 '-' r '-' num2str(c)  '-' num2str(niter) '-' num2str(k) '-bund_size.tif']; %  num2str(kappa) '-' num2str(k) '-bund_size.tif'];

            hold off; 
            fid3 = fopen( ofs6, 'w+' );
             if fid3 >= 0
                ImZ = imresize(ImZ,.25);
                %imwrite ( ImZ,ofs6 ); % 
                saveas (ImZ,ofs6,'tif');
                fclose(fid3);
             end
        end
    end
     end % end of " if (numel(X(:,2)) > 20 & numel(X(:,1)) > 20 ) "
    %%%%%
    
    close all; 
    
    end % end the if statement in line 1293( if numel (X) > 2)
    else 
        ;
    end % end the if statement in line 1056 ( if xnormal > 0 )
    fclose( 'all' );
     else
         fprintf (['Can not process the image '  nm1 '-' num2str(c) '-' num2str(niter) '-' num2str(k) ]); % num2str(kappa) '-' num2str(k) ]);
     end % end of the if statement in line 1061 ( if  numel(X(:,2))== numel(X(:,1)) )
    end % end of the "image dimensionality if"
   end % end of the "k - for - loop"
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 fclose( 'all' );
    
    %%%
 end  
 

    
    %%%%
    % AUTOCROPPING STARTS :
    
                    case 'No'
               
        
 for c = 1 : numel(s) % 1 : numel(s)       % start of loop 3 ("image cropping and analysis")
    
     numovascbundles = 0;
     
     Ic = imcrop(rgb, s(c).BoundingBox);  % for cropping the entire stalk
     if ( size( Ic,1 ) < 1500 && size( Ic,2 ) < 1500 )
     % Ic = imcrop(rgb0, wegschneid); % imcrop(rgb, wegschneid); % figure; imshow(Ic);
     [pth,nm1,ext] = fileparts(fileList{1}{a});
                        
                % ofs2 = [OutPath nm1 '-' r '-' num2str(c) '-' num2str(v)   '.tif'];
                % ofs2 = [OutPath nm1 '-' r '-' num2str(c) '-' rho   '.tif'];
                ofs2 = [OutPath nm1 '-' r '-' num2str(c)   '.tif']; % !!! %%%
                %%% !!!  ofs2 = [OutPath nm1 '-' num2str(c)   '.tif'];
                Im = figure; 
                imshow( Ic ), title( ['cropped image - '  num2str(c)] ); % num2str(v)]);
                hold on;        
                Im = imresize( Im,.25 );
                hold off;
                fid2 = fopen( ofs2, 'w+' ); % ('output.txt','w');
                if fid2 >= 0
                   saveas ( Im, ofs2, 'tif' ); % imwrite( Im, ofs2 ); % 
                   fclose(fid2);
                end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ic = imcrop(rgb, s(c).BoundingBox);  % for cropping the entire stalk
% Ic = imcrop(rgb0, s(c).BoundingBox);
I0 = im2double(Ic);
   
G = imfilter(I0(:,:,2), fspecial('gaussian', 6, 3)); % imfilter(I0(:,:,3), fspecial('gaussian', 6, 3)); 

    t = 1; figure; imshow( Ic, [], 'InitialMagnification', 2000 );
%Im = figure;
for p = 1 : 0.3 : 2.5  % start of loop 6 ("determine the area of the pith")
    F = G > graythresh(G) / p;
    
    % Im = figure;
    % figure; imshow(Ic, []); % imshow(I0, []);
    hold on; % Prevent plot() from blowing away the image.
    % title('Original Color Image with Pith and Stalk Outlined');
    %figure;
    subplot(2, 3, t);
    t = t + 1;
    % imshow(Ic, [], 'InitialMagnification', 2000);
    
    % figure; 
    % subplot(2, 4, t);
    imshow(Ic, [], 'InitialMagnification', 2000);
    hold on;
    himage = imshow(F);
    set(himage, 'AlphaData', 0.5);
    title([ num2str(p) ' x Otsu thresh'], 'FontSize', 8)
    axis tight;
    axis off;
    % p = p + 1;
end
 
  totalareathresh = inputdlg('Please tell me which graythresh describes the outline of the whole stalk best' );
  totalthresh = str2num(totalareathresh{:});
  F = G > graythresh(G) / totalthresh;
close;

   [pth,nm1,ext] = fileparts(fileList{1}{a});
   
            % ofs3 = [OutPath nm1 '-' r '-' num2str(c) '-' num2str(v) '- whole stalk.tif'];
            ofs3 = [OutPath nm1 '-' r '-' num2str(c) '- whole stalk.tif'];
            % %% !!! ofs3 = [OutPath nm1 '-' num2str(c) '- whole stalk.tif'];
            Im = figure; 
            imshow(Ic, []); % , 'InitialMagnification', 2000); 
            title('Area of the entire stalk');
            hold on;
            %himage = imshow(F);
            %set(himage, 'AlphaData', 0.5);
            boundaries = bwboundaries(F);
           
            [max_size, max_index] = max(cellfun('size', boundaries, 1));
            blobBoundary = boundaries{ max_index };
            plot(blobBoundary(:,2), blobBoundary(:,1), 'r-', 'LineWidth', 2);
            hold off;
            % pause(5);
            Im = imresize(Im,.25);
             fid2 = fopen(ofs3, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im,ofs3,'tif');
                   fclose(fid2);
                end
    
labeledImage_all = bwlabel(F, 8);
labeledImage_all =  bwareaopen( labeledImage_all, 500 );
% coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels
% figure, imagesc(coloredLabels), title('Pseudo colored labels');
blobMeasurements_all = regionprops(labeledImage_all, 'all'); % Get all the blob properties.
area_value_stalk = [blobMeasurements_all.Area];
area_value_stalk = max(area_value_stalk);
%length_value_stalk = [blobMeasurements_all.MajorAxisLength] % 
%minlength_value_stalk = [blobMeasurements_all.MinorAxisLength] % ;
% Get a list of the areas.
%C = (I0(:,:,1) .* I0(:,:,2) .* I0(:,:,3)) > 0.15; figure; imshow(C, []);
% Q = Ihmf_spatial(:,:,1).*Ihmf_spatial(:,:,2).*Ihmf_spatial(:,:,3); % 
%%%%%%%%%

info = questdlg('Would you like to measure the stalk`s extensions?', 'Length and Width?', 'Yes!', 'No.', 'Yes!');
                % Handle response
                switch info
                    case 'Yes!'
Ibw = labeledImage_all;
 
%%% Calculate axis and draw

[M N] = size(Ibw);
[X Y] = meshgrid(1:N,1:M);

%Mass and mass center
m = sum(sum(Ibw));
x0 = sum(sum(Ibw.*X))/m;
y0 = sum(sum(Ibw.*Y))/m;

%Covariance matrix elements
Mxx = sum(sum((X-x0).^2.*Ibw))/m;
Myy = sum(sum((Y-y0).^2.*Ibw))/m;
Mxy = sum(sum((Y-y0).*(X-x0).*Ibw))/m;

MM = [Mxx Mxy; Mxy Myy];

[U S V] = svd(MM);

W = V(:,1)/sign(V(1,1)); %Extremal directions (normalized to have first coordinate positive)
H = V(:,2);
W = 2*sqrt(S(1,1))*W; %Scaling of extremal directions to give ellipsis half axis
H = 2*sqrt(S(2,2))*H;

figure; imshow(Ibw);

hold on;  
ctr = blobMeasurements_all.Centroid;
theta = blobMeasurements_all.Orientation;

hold on
    plot(x0,y0,'b*');
    plot(x0,y0,'bo');
    quiver(x0,y0,W(1),H(1),'r', 'lineWidth', 3)
    quiver(x0,y0,W(2),H(2),'g', 'lineWidth', 1)
hold off

 pause( 2 );
 close;
 long_axis_stalk = 0;
 short_axis_stalk = 0;
  LONG_AXIS = regionprops(labeledImage_all, 'MajorAxisLength'); 
  maxVals = arrayfun(@(struct)max(struct.MajorAxisLength(:)),LONG_AXIS);
  long_axis_stalk = max(maxVals(:));

  SMALL_AXIS = regionprops(labeledImage_all, 'MinorAxisLength'); 
  minVals = arrayfun(@(struct)max(struct.MinorAxisLength(:)),SMALL_AXIS);
  short_axis_stalk = max(minVals(:));
  
                    case 'No.'
long_axis_stalk = 0;
short_axis_stalk = 0;
                end

%%%%%%%%%
Q = (I0(:,:,1) .* I0(:,:,2) .* I0(:,:,3)); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 1; 
figure, imshow (rgb, [], 'InitialMagnification', 2000);
for q = 0 : 0.3 : 2.1
    H = Q > (graythresh(Q) / q);
    %H = ((I0(:,:,1) .* I0(:,:,2) .* I0(:,:,3)) > 0.1); 
    H = imfilter(H, fspecial( 'gaussian', 10, 10 ) ); % figure; imshow(H); % inner parts of the stalk 
    % figure; 
    subplot(2, 4, p);
    imshow(Ic, [], 'InitialMagnification', 2000);
    hold on;
    himage = imshow(H);
    set(himage, 'AlphaData', 0.5);
    title([ num2str(q) ' times the Otsu graythresh'])
    axis tight;
    axis off;
    p = p + 1;
end

totalinsidethresh = inputdlg('Please tell me which graythresh describes the outline of the pith best' );
insidethresh = str2num(totalinsidethresh{:});
H = Q > graythresh(Q) / insidethresh;
close;
    
    labeledImage_inside = bwlabel(H, 8);
    % coloredLabels = label2rgb (labeledImage_inside, 'hsv', 'k', 'shuffle'); % pseudo random color labels
    % figure, imagesc(coloredLabels), title('Pseudo colored labels');
    blobMeasurements_inside = regionprops(labeledImage_inside, 'all'); % Get all the blob properties.
    area_value_inside_a = [blobMeasurements_inside.Area];
    biggestBlobIndex = find(area_value_inside_a == max(area_value_inside_a));
    keeperBlobsImage = ismember(labeledImage_inside, biggestBlobIndex);
    % keeperBlobsImage_open = imopen(keeperBlobsImage, strel('disk', 6)); % figure; imshow(keeperBlobsImage_open); 
    keeperBlobsImage_close = imclose(keeperBlobsImage, strel('disk', 10)); % figure; imshow(keeperBlobsImage_open); 

   
area_value_inside_b = regionprops(keeperBlobsImage_close, 'all');
area_value_inside_c = [area_value_inside_b.Area];
area_value_inside = area_value_inside_c; % find(area_value_inside_c == max(area_value_inside_c));
%length_value_inside = [blobMeasurements_inside.MajorAxisLength] % ;
%minlength_value_inside = [blobMeasurements_inside.MinorAxisLength] % ;
area_value_rind = area_value_stalk - area_value_inside;
percent_inside = area_value_inside * (100 / area_value_stalk);
%length_value_rind = length_value_stalk - length_value_inside
%minlength_value_rind = minlength_value_stalk - minlength_value_inside
% figure, imshow(I0,[]); % , title('Entropy Filtered Scanner Image'); 
%%%%
Wb = bwboundaries(F);
Ib = bwboundaries(keeperBlobsImage_close); % (H);
W = 0;
% figure;
for i = 1:size(Wb{1},1)
    delta = bsxfun(@minus,Ib{1},Wb{1}(i,:));
    dist = sum(delta.*delta,2).^.5;
    if min(dist) > 10
        [W(i) idx] = min(dist);
    else
        W(i) = 0;
    end
    %{
    plot(Ib{1}(:,2),Ib{1}(:,1),'r');
    hold on;
    plot(Wb{1}(:,2),Wb{1}(:,1),'b');
    plot(Wb{1}(i,2),Wb{1}(i,1),'b*');
    plot(Ib{1}(idx,2),Ib{1}(idx,1),'r*');
    drawnow;
    hold off;
    %}
end
    % figure;plot(W);
    % MW = mean(W);
    
    MW = 0;
    % Idx = 0;
    % nIdx = 0;
    Idx = find(W(:) ~= 0);
    nIdx = numel(Idx);
    for i = 1:size(W,2)
        if W(i) ~= 0
            MW = (MW + W(i));
        else 
            MW = MW;
        end
    end
    MW = MW / nIdx;

    
[pth,nm1,ext] = fileparts(fileList{1}{a}); % (O.fileName);
    fclose('all');
    %outfile = [area_value_stalk, area_value_inside, area_value_rind, length_value_stalk, length_value_inside, length_value_rind, minlength_value_stalk, minlength_value_inside, minlength_value_rind,  numovascbundles, bundle_density];
   
%end                      % end of loop 6 ("determine the area of the pith")
hold off;
Im_pith = figure; imshow(Ic, []);
hold on; % Prevent plot() from blowing away the image.
title('Original Color Image with Pith Outlined');
% Get its boundary and overlay it over the original image.
boundaries = bwboundaries(keeperBlobsImage_close);
%blobBoundary = boundaries{1};
[max_size, max_index] = max(cellfun('size', boundaries, 1));
blobBoundary = boundaries{ max_index };
plot(blobBoundary(:,2), blobBoundary(:,1), 'r-', 'LineWidth', 2);
hold off;

Im_pith = imresize(Im_pith,.25);
ofs4 = [OutPath nm1 '-' r '-' num2str(c) '- pith.tif'];
fid2 = fopen(ofs4, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im_pith,ofs4,'tif');
                   fclose(fid2);
                end
hold off;
close all;
%end            % start of loop 5 ("determine the area of the entire stalk")

%%%%
 I2 = rgb2gray(I0); % figure; imshow(I2); % / max(max(I0));
 % I2 = imdilate(I2, strel('disk', 7)); % figure; imshow(I2); 3 works good!
 %%Maize:
 
 for n = 0.1 : 0.1 : 1
     if n == 0.1
 bI = ~(imadjust(I2 - (graythresh(I2) / 1.5)) > n); %figure, imshow(bI,[]), title('binarised image'); % if im2double was used
     else
 bI = bI - ~(imadjust((I2 - (graythresh(I2) / 1.5))) > n) ; % figure, imshow(bI,[]), title('binarised image'); % if im2double was used
     end
 end
 
 %%Sorghum:
 %bI = I2; 
 % bI = imadjust(I2);
 % figure, imshow(bI,[]), title('image before binarisation');
 bI = abs(bI); % figure, imshow(bI,[]), title('image before binarisation');
 G = fspecial('gaussian', [100 100], 100); G = G * 10000; [n, m] = size(bI);  % fspecial('gaussian', [20 20], 25); G = G * 10000; [n, m] = size(bI); 
 % G = fspecial('gaussian', [8 8], 8); G = G * 10000; [n, m] = size(bI); 
 % G = fspecial('gaussian', [round(position(3)/2) round(position(4)/2)], round(position(3)/4)); G = G * 10000; [n, m] = size(bI); 
 F2 = real(ifft2(fft2(bI) .* fft2(rot90(G), n, m))); 
 % figure; imshow(F2, []); %, 'InitialMagnification', 'fit');
 A = F2 / max(max(F2));
 B = A > 0.15; % figure; imshow(B);
 % sig = round(position(4)/2); 
 sig = 2; % 20;
 bImask = imfilter(bI,fspecial('gaussian',[2*sig 2*sig],sig),'replicate'); 
 %bImask = ~(bImask); bImask = (bImask / max(max(bImask))); 
 bImask = abs(bImask);
 bImaska = bImask > 5;
 bImask = ~bImaska;
 % figure, imshow(bImask,[]), title('binarised mask');
 
 bIabs = abs(bI); % figure, imshow(bIabs,[]);
 bItry = bIabs / max(max(bIabs)); % normalize the image to 1

 %%% BEGINNING: Filtering in "case 'No'"
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Filtering using anisotropic diffusion
 % from www.csse.uwa.edu.au/~pk/Research/MatlabFns/Spacial/anisodiff.m
     im = bItry;
     [rows,cols] = size(im);
     diff = im;
     niter = 130; % 70; works good
     kappa = 0.2; % 40; works good!
     lambda = 0.16;
     option = 2;
    for i = 1:niter
    %  fprintf('\rIteration %d',i);

      % Construct diffl which is the same as diff but
      % has an extra padding of zeros around it.
      diffl = zeros(rows+2, cols+2);
      diffl(2:rows+1, 2:cols+1) = diff;

      % North, South, East and West differences
      deltaN = diffl(1:rows,2:cols+1)   - diff;
      deltaS = diffl(3:rows+2,2:cols+1) - diff;
      deltaE = diffl(2:rows+1,3:cols+2) - diff;
      deltaW = diffl(2:rows+1,1:cols)   - diff;

      % Conduction

      if option == 1
        cN = exp(-(deltaN/kappa).^2);
        cS = exp(-(deltaS/kappa).^2);
        cE = exp(-(deltaE/kappa).^2);
        cW = exp(-(deltaW/kappa).^2);
      elseif option == 2
        cN = 1./(1 + (deltaN/kappa).^2);
        cS = 1./(1 + (deltaS/kappa).^2);
        cE = 1./(1 + (deltaE/kappa).^2);
        cW = 1./(1 + (deltaW/kappa).^2);
      end

      diff = diff + lambda*(cN.*deltaN + cS.*deltaS + cE.*deltaE + cW.*deltaW);

    end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 bItry = diff; % imadjust(diff); 
 %figure, imshow(bItry), title('after adjusting the contrast');
 
 D = imregionalmax(bItry); figure; imshow(D);
 E = H & B & D; % & bImask
 % figure; imshow(E);
 K = F & ~keeperBlobsImage_close; % H; % figure; imshow(K);
 % close all; %%%%%%%%%%%%%%%%%%%%%%%%%% REMOVE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 figure; imshow(Ic); % imshow(rgb2gray(I0));
 hold on;
 plot(blobBoundary(:,2), blobBoundary(:,1), 'b-', 'LineWidth', 1);
 %himage = imshow(E);
 %set(himage, 'AlphaData', 0.5);
 title('Pith outline and found vascular bundles superimposed on original image');
 samp = find(E);
 [samp1, samp2] = find(E == 1);
 Z = [samp1, samp2];

 scatter (Z(:,2), Z(:,1) , 'r.');
 % hold off;
 info = questdlg('Would you like to add some more peaks to the found ones', 'Less peaks found than actually there?', 'Yes!', 'No.', 'Yes!');
                % Handle response
                switch info
                    case 'Yes!'
                        lint = inputdlg('Please enter the number of bundles you want to add: ' );
                        l = str2num(lint{:});
                        [T1, T2] = ginput(l);
                        pos_x = round(T1); 
                        pos_y = round(T2);
                        % pos = [pos_x, pos_y];
                        pos = [pos_y, pos_x];
                        Z = [Z; pos];
                        scatter (Z(:,2), Z(:,1) , 'r.');
                        scatter(pos(:,2), pos(:,1) , 'bo');
                        % pause(5);
                        info = questdlg(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk'], 'Number of vascular bundles', 'OK!', 'OK!');
                        numovascbundles = numel(Z(:,1)); % numovascbundles = numel(samp) + numel(pos,1);
                        switch info
                            case 'OK!'
                                disp([info ':  So far so good.'])
                        end
                    case 'No.'
                        l = 0;
                        info = questdlg(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk'], 'Number of vascular bundles', 'OK!', 'OK!');
                        % Handle response
                        switch info
                            case 'OK!'
                                disp([info ':  So far so good.'])
                                 numovascbundles = numel(Z(:,1)); % numovascbundles = numel(samp);
                        end
                end
 
 
 % area_value_inside = area_value_inside / (316.6)^2; 
 % bundle_density = numovascbundles / area_value_inside;
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    hold off;
 
info = questdlg(['Would you like to keep these results or would you like to retry with a new crop box? '], 'Carry on?',  'Carry on!', 'One more try',  'Carry on!');
                % Handle response
                switch info
                     case 'One more try'
                             disp([info ':  Now comes trial # 2 '])
                          [percent_inside, MW, Z, area_value_stalk, area_value_inside, area_value_rind, numovascbundles, bundle_density ] = drier_piece(rgb, OutPath, nm1, r, c);
                          percent_inside = area_value_inside * (100 / area_value_stalk);  
                          info = questdlg('Would you like to keep these results or would you like to retry with a new crop box? ', 'Carry on?',  'Carry on!', 'One more try',  'Carry on!');
                                % Handle response
                                switch info
                                     case 'One more try'
                                          disp([info ':  Now comes trial # 3 '])
                                          [ percent_inside, MW, Z, area_value_stalk, area_value_inside, area_value_rind, numovascbundles, bundle_density ] = drier_piece(rgb, OutPath, nm1, r, c)
                                          %percent_inside = area_value_inside * (100 / area_value_stalk);  
                                          info = questdlg('Would you like to keep these results or would you like to retry with a new crop box? ', 'Carry on?',  'Carry on!', 'One more try',  'Carry on!');
                                                % Handle response
                                                switch info
                                                     case 'One more try'
                                                             disp([info ':  Now comes trial # 4 '])
                                                          [ percent_inside, MW, Z, area_value_stalk, area_value_inside, area_value_rind, numovascbundles, bundle_density ] = drier_piece(rgb, OutPath, nm1, r, c)
                                                            %percent_inside = area_value_inside * (100 / area_value_stalk);
                                                            info = questdlg('That was your last try with this stalk. If you want to try again, please start the program again.', 'OK',  'OK!');
                                                                % Handle response
                                                                switch info
                                                                    case 'OK'
                                                                        disp([info ':  OK, than let us look at the indivdual vascular bundles. This was stalk # ' num2str(c) ' . '])
                                                                end
                                                        %disp([info ':  OK, than let us look at the next stalk. This was stalk # ' num2str(c) ' . '])
                                                end     
                                     case 'Carry on!'
                                        disp([info ':  OK, than let us look at the indivdual vascular bundles. This was stalk # ' num2str(weiter) ' . '])
                                end     
                     case 'Carry on!'
                        disp([info ':  OK, than let us look at the indivdual vascular bundles. This was stalk # ' num2str(c) ' . '])
                end                
          
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ofs5 = [OutPath nm1 '-' r '-' num2str(c) '- counted bundles.tif'];
    Im = figure;
    imshow(Ic);
    hold on;
    scatter (Z(:,2), Z(:,1) , 'r.');
    title(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk']);
    hold off; 
    Im = imresize(Im,.25);
     fid2 = fopen(ofs5, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im,ofs5,'tif');
                   fclose(fid2);
                end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    ofs7 = [OutPath nm1 '-' r '-' num2str(c) '- counts outlined.tif'];
    Im7 = figure;
    imshow(Ic);
    hold on;
    scatter (Z(:,2), Z(:,1) , 'r.');
    title(['There are ' num2str(numel(Z(:,1))) ' vascular bundles in the stalk']);
    plot(blobBoundary(:,2), blobBoundary(:,1), 'b-', 'LineWidth', 1); 
    title('Pith outline and found vascular bundles superimposed on original image');
    hold off; 
    Im7 = imresize(Im7,.25);
     fid2 = fopen(ofs7, 'w+'); % ('output.txt','w');
                if fid2 >= 0
                   saveas (Im7,ofs7,'tif');
                   fclose(fid2);
                end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    long_axis_stalk = long_axis_stalk/316;
    short_axis_stalk = short_axis_stalk/316; 
    MW = MW / 316;
    area_value_inside = area_value_inside / (316)^2; 
    bundle_density = numovascbundles / area_value_inside;
    % area_value_inside = area_value_inside / (316.6)^2; 
    % bundle_density = bundle_density / (316.6)^2; 
    %outfile = [MW, area_value_inside, percent_inside];
    Zhelp = (numel(Z))/2;
    success_rate = 100 - ( (100/Zhelp)*l ); 
    outfile = [MW, area_value_inside, percent_inside, numovascbundles, bundle_density, long_axis_stalk, short_axis_stalk]; % , l, success_rate ];
    
 [pth,nm1,ext] = fileparts(fileList{1}{a}); % (O.fileName);
    fclose('all');  
    
    output = [OutPath  nm1 '-' r '-' num2str(c) '-rindthickness-pitharea-percentpith-numobundles-bundledens-longaxis-shortaxis.xls'];
    fid2 = fopen(output, 'w+'); % ('output.txt','w');
    if fid2 >= 0
        % xlswrite( output,outfile); % , '-append', 'newline', 'unix', 'delimiter','\t');
        csvwrite( output,outfile);
        fclose(fid2);
    end
                 
    close all; 
    
    Igreen = Ic (:,:,2); % = Ic(:,:,3) .* ( (abs( 255 - (imadjust(Ic(:,:,2) - (Ic(:,:,1)))))) /255 ); % 
    
    %%% Determine the size of the bundles
    for k = 1 : size(Z,1) % 10 %
    
    h = 15; % 15; 
    w = 15; % 15;
    brala = size(Ic);
    if (round(Z(k,1)- h) > 0  && round(Z(k,2)- w) > 0 && round(Z(k,1)+ h) < brala(1) && round(Z(k,2)+ w) < brala(2))
    % Ishow = Ic((abs( round(Z(k,1)) - h ) ) : abs( round(Z(k,1))+ h) , abs( (round(Z(k,2))- w ) ) : abs( round(Z(k,2)) + w), :);
    % Ifit = Igreen((abs(round(Z(k,1)) - h ) ) : abs( round(Z(k,1))+ h) , abs( (round(Z(k,2))- w ) ) : abs( round(Z(k,2)) + w) , :);
    Ishow = Ic(( round(Z(k,1)) - h  ) :  (round(Z(k,1))+ h) , (round(Z(k,2))- w  ) : ( round(Z(k,2)) + w), :);
    Ifit = Igreen(((round(Z(k,1)) - h ) ) : ( round(Z(k,1))+ h) , ( (round(Z(k,2))- w ) ) : ( round(Z(k,2)) + w) , :);
    
    %%%%%
    ImZ = figure;           % Start a new figure to show the plots
    
   
    %%%%%
    subplot(2, 3, 1);
    Ione = cat(3, (Ishow(:,:,1))', (Ishow(:,:,2))', (Ishow(:,:,3))' );
    imshow(Ione, []);
   
    %%%
    % http://blogs.mathworks.com/steve/2013/06/25/homomorphic-filtering-part-1/
    %%%
    Ifitadd = im2double(Ifit);
    Ifitadd = log(1 + Ifitadd);
    sigma = 10; % 20; % MAY BE TOO BIG!!!!!
    M_HP = 2*size(Ifitadd,1) + 1;
    N_HP = 2*size(Ifitadd,2) + 1;
    [X, Y] = meshgrid(1:N_HP,1:M_HP);
    centerX = ceil(N_HP/2);
    centerY = ceil(M_HP/2);
    gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
    H_HP = exp(-gaussianNumerator./(2*sigma.^2));
    H_HP = 1 - H_HP;
    %imshow(H_HP,'InitialMagnification',25);
    
    If = fft2(Ifitadd, M_HP, N_HP);
    Iout = real(ifft2(H_HP.*If));
    Iout = Iout(1:size(Ifitadd,1),1:size(Ifitadd,2));
    Ihmf_2 = exp(Iout) - 1;
    %imshow(Ihmf_2, []);
    filterRadius = sigma;
    filterSize = 2*filterRadius + 1;
    hLowpass = fspecial('average', filterSize);
    hImpulse = zeros(filterSize);
    hImpulse(filterRadius+1,filterRadius+1) = 1;
    hHighpass = hImpulse - hLowpass;
    Ihmf_spatial = imfilter(Ihmf_2', hHighpass, 'replicate');
    % Ihmf_spatial = imfilter(Ifitadd, hHighpass, 'replicate');
    Ihmf_spatial = exp(Ihmf_spatial) - 1;
    % imshow(Ihmf_spatial, []);
    %%%
    % http://blogs.mathworks.com/steve/2013/07/10/homomorphic-filtering-part-2/
    %%%
   
    M =  Ihmf_spatial < -(graythresh(Ihmf_spatial));
   
    M = bwareaopen(M, 25);
    X = [0, 0];
    o = 1;
    for m = 1 : size(Ifit,1) % for m = 1 : size(Ifit,1)
        for n = 1 : size(Ifit,1) % for n = 1 : size(Ifit,1)
            if (M(m,n) == 1)
                X(o,1) = m;
                X(o,2) = n;
                o = o + 1;
            else
                ;
            end
        end
    end
   
     %%%%%
     if  numel(X(:,2))== numel(X(:,1))
         
    subplot(2, 3, 2);       % Show the original unchanged b&w image
    imshow(Ifit',[]);
    title([num2str(c) '-' num2str(niter) ', Bundle # ' num2str(k) ]); %  num2str(kappa) '-' num2str(niter) ', Bundle # ' num2str(k) ]);
    
    %%%%%
    subplot(2, 3, 4);       % Show the distribution of brightnesses along the mean in x direction
    
    xProfile = mean(Ifit);  % Average over all lines in x direction
    xx = linspace(-(numel(xProfile)/2), (numel(xProfile)/2), numel(xProfile));
    plot(xx, xProfile);     % Show the average over all lines in x direction
    title('horizontal profile');
    axis tight;
    
    xac = xcov(xProfile);                       % unbiased autocorrelation
    xac = xac - min(xac);                       % normalize autocorrelation to 0 
    xxx = linspace(-(numel(xac)/2), (numel(xac)/2), numel(xac));
    
    xnormal = abs(max(max(xProfile)));
    %xnormal = max(max(xProfile)); % for scaling of the autocorrelation to show it on the picture
    if xnormal > 0
    
    A = find(floor(xac)==0);
    if numel (A) > 2
        
        for blubberbert = 1 : numel (xac)
            if blubberbert < A(ceil((numel(A))/2))
                xac(blubberbert) = 0;
            elseif blubberbert > A(ceil(((numel(A))/2)+1))
                xac(blubberbert) = 0;
            end
        end
        
    else
        %{
        for blubberbert = 1 : numel (xac)
        xac(blubberbert) = 0;
        end
        %}
        for blubberbert = 1 : numel (xac)
            if blubberbert < A(1)
                xac(blubberbert) = 0;
            elseif (numel(A)>1 && blubberbert >= A(2))
                xac(blubberbert) = 0;
            end
        end
        %{
        %}
    end
    xac = (xac /(max(max(xac)))) * xnormal;
    
    %%%%%
    subplot(2, 3, 5);       % Show the distribution of brightnesses along the mean in y direction
    
    yProfile = mean(Ifit'); % Average over all lines in y direction
    yx = linspace(-(numel(yProfile)/2), (numel(yProfile)/2), numel(yProfile));
    plot(yx, yProfile); 	% Show the average over all lines in y direction
    title('vertical profile');
    axis tight
    
    ynormal = max(max(yProfile)); % for scaling of the autocorrelation to show it on the picture
    yac = xcov(yProfile);                        %unbiased autocorrelation
    yac = yac - min(yac);
    xx = linspace(-(numel(yac)/2), (numel(yac)/2), numel(yac));
    
    B = find(floor(yac)==0);
    if numel (B) > 2
        
        for blubberbert = 1 : numel (yac)
            if blubberbert < B(ceil((numel(B))/2))
                yac(blubberbert) = 0;
            elseif blubberbert > B(ceil(((numel(B))/2)+1))
                yac(blubberbert) = 0;
            end
        end
    else
        
        for blubberbert = 1 : numel (yac)
            if blubberbert < B(1)
                yac(blubberbert) = 0;
            elseif (numel(B)>1 && blubberbert >= B(2)) % blubberbert >= B(2)
                yac(blubberbert) = 0;
            end
        end
        %{
        %}
    end
    yac = (yac /(max(max(yac)))) * ynormal;
    % plot(xxx, yac);
    axis tight;
    hold on;
    
    %%%%%
    subplot(2, 3, 3);   % Show the original unchanged b&w image with the results of the autocorrelation 
    Imshow = cat(3, (Ishow(:,:,1))', (Ishow(:,:,2))', (Ishow(:,:,3))' );
    imshow(Imshow,[]);% imshow(Ishow,[]); % imshow(M); %
   
    %%%%%%
    if numel (X) < 2 || ( X(1) == 0 && X(2) == 0 ) 
        subplot(2, 3, 6); % subplot(2, 3, 4);
        plot(X(:,1), X(:,2), 'b.');
        text(1, 1000, 'Image can not be analysed', 'fontsize', 7);
        subplot(2, 3, 6); % subplot(2, 3, 5);
        plot(X(:,1), X(:,2), 'b.');
        text(1, 1000, 'Image can not be analysed', 'fontsize', 7);
        brara = [1, 1 ; 1, 1];
        close all;
      
    else   
        Imshow = cat(3, (Ishow(:,:,1))', (Ishow(:,:,2))', (Ishow(:,:,3))' );
        imshow(Imshow,[]);% imshow(Ifit',[]);
        options = statset('Display','final');
        if (numel(X(:,2)) > 20 & numel(X(:,1)) > 20 )
            obj = gmdistribution.fit(X,1,'Options',options);
            hold on
            %ezcontour(@(x,y)pdf(obj,[x y]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            ezcontour(@(x,y)pdf(obj,[y x]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            
            hold off
            ComponentMeans = obj.mu;
            ComponentCovariances = obj.Sigma;
            MixtureProportions = obj.PComponents;

            %%%%%
            subplot(2, 3, 6);   % Show the vascular bundle as a cloud of scattered spots 
            %%%% neu
           
            scatter((X(:,2)), (X(:,1)), 'k.'); axis([0 size(Ifit,1) 0 size(Ifit,1)]);
            hold on
            %ezcontour(@(x,y)pdf(obj,[x y]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            ezcontour(@(x,y)pdf(obj,[y x]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            % h = ezcontour(@(x,y)pdf(obj,[x y]),[0 size(Ifit,1) ],[0 size(Ifit,1)]);
            t = findall(gcf,'type','text');
            % delete the text objects
            delete(t);
            hold off
            brara = sqrt(obj.Sigma);
       
    %end % end the if statement in line 1293( if numel (X) > 2)
    %%%%%
    %if (numel(A) > 1 & numel(B) >1 && brara(1) - brara(4) > 1 && brara(1) < 11 ) % && brara(4) < 5 )
    if  min(min(Ihmf_spatial)) < -0.04
        if  brara( 1, 1 ) > brara( 2, 2 ) 
            Awert = brara( 1, 1 );
            Bwert = brara( 2, 2 );
        else
            Awert = brara( 2, 2 );
            Bwert = brara( 1, 1 );
        end
        Cwert = ( Awert / Bwert );
         if Cwert < 2
            %%%%%%
            % brara = sqrt(obj.Sigma);
            % outfile =  [brara(1,1)*((316.6)^.5), brara(2,2)*((316.6)^.5), (pi*brara(1,1)*brara(2,2)/ 316.6)]; % ComponentCovariances(:)';
            outfile =  [brara(1,1)/(316), brara(2,2)/(316), (pi*brara(1,1)*brara(2,2)/( 316*316 ))]; % ComponentCovariances(:)';
            output = [OutPath 'Bundles\' nm1 '-' r '-' num2str(c) '-' num2str(niter) '-'  num2str(k) '-bund_size.xls']; % num2str(kappa) '-' num2str(k) '-bund_size.xls'];
            fid2 = fopen(output, 'w+'); % ('output.txt','w');
            if fid2 >= 0
                csvwrite( output, outfile);
                % xlswrite( output,outfile); % , '-append', 'newline', 'unix', 'delimiter','\t');
                fclose(fid2);
            end

            ofs6 = [OutPath 'Bundles\' nm1 '-' r '-' num2str(c)  '-' num2str(niter) '-' num2str(k) '-bund_size.tif']; %  num2str(kappa) '-' num2str(k) '-bund_size.tif'];

            hold off; 
            fid3 = fopen( ofs6, 'w+' );
             if fid3 >= 0
                ImZ = imresize( ImZ, .25 );
                %imwrite ( ImZ,ofs6 ); % 
                saveas ( ImZ, ofs6, 'tif');
                fclose( fid3 );
             end
        end
    end
     end % end of " if (numel(X(:,2)) > 20 & numel(X(:,1)) > 20 ) "
    %%%%%
    
    close all; 
    
    end % end the if statement in line 1293( if numel (X) > 2)
    else 
        ;
    end % end the if statement in line 1056 ( if xnormal > 0 )
    fclose( 'all' );
     else
         fprintf (['Can not process the image '  nm1 '-' num2str(c) '-' num2str(niter) '-' num2str(k) ]); % num2str(kappa) '-' num2str(k) ]);
     end % end of the if statement in line 1061 ( if  numel(X(:,2))== numel(X(:,1)) )
    end % end of the "image dimensionality if"
   end % end of the "k - for - loop"
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 fclose( 'all' );
 %%% END: Filtering in "case 'No' "
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 fclose( 'all' );
 %end               % end of loop 4 ("individual cropping of parts of stalk")
     else 
     c = c + 1 ;
     end % end of if ( size( Ic,1 ) < 750 &size( Ic,1 ) < 750 )
 
 end                        % end of loop 3 ("image cropping and analysis") 
 close all; % closes all the images from one genotype  TAKE THIS BACK INTO THE CODE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
                end % end of "Do you want to crop yourself?"
end  % end of "for b = 1:4" in line 42  --> end of loop 2 ("proccess the parts of the image")
end                                % end of loop 1 ("load the whole image")
       end
 catch ME
     ME
     ME.stack
 end   



end