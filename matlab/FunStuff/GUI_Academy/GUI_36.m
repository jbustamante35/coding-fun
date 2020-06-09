function [R] = GUI_36()
% Get information from a GUI to the command line.
% How to make a GUI that returns information to caller?
% How to initialize the string as active in an editbox
% Suggested exercise:  How would you modify this code so that the default
% answer 'Enter Some Data' cannot be returned?
R = [];
S.fh = figure('units','pixels',...
              'position',[500 500 200 130],...
              'menubar','none',...
              'name','GUI_36',...  
              'numbertitle','off',...
              'resize','off');
S.ed = uicontrol('style','edit',...
                 'units','pix',...
                'position',[10 60 180 60],...
                'string','Data');
S.pb = uicontrol('style','pushbutton',...
                 'units','pix',...
                'position',[10 20 180 30],...
                'string','Push to Return Data');
set(S.pb,'callback',{@pb_call,S})            
waitfor(S.ed)

if ishandle(S.fh)
    F = get(S.pb,'callback');
    R = F{2}.R;
    close(S.fh)
end


function [] = pb_call(varargin)
S = varargin{3};
S.R = get(S.ed,'string');
set(S.pb,'callback',{@pb_call,S});
delete(S.ed);
       