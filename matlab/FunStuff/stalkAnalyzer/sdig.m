function [SET] = sdig(FilePath,FileList,FileExt,verbose)
    
    %%% get file list
    FileList = gdig(FilePath,FileList,FileExt,verbose);
    
    %%% sep into sets
    for i = 1:size(FileList,1)
        [pth{i} nm{i}] = fileparts(FileList{i});
    end
    
    %%% sep into sets
    [UQ ia ic] = unique(pth);
    for u = 1:size(UQ,2)
        SET{u} = FileList(ic==u);
    end
    
end

%{
    FilePath = '/mnt/spaldingimages/';
    FileList = {};
    FileExt = {'tiff','TIF'};
    verbose = 1;
    SET = sdig(FilePath,FileList,FileExt,verbose);
%}