function varargout = autoSegmenter(varargin)
% AUTOSEGMENTER MATLAB code for autoSegmenter.fig
%      AUTOSEGMENTER, by itself, creates a new AUTOSEGMENTER or raises the existing
%      singleton*.
%
%      H = AUTOSEGMENTER returns the handle to a new AUTOSEGMENTER or the handle to
%      the existing singleton*.
%
%      AUTOSEGMENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOSEGMENTER.M with the given input arguments.
%
%      AUTOSEGMENTER('Property','Value',...) creates a new AUTOSEGMENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autoSegmenter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autoSegmenter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autoSegmenter

% Last Modified by GUIDE v2.5 02-Jul-2017 21:15:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autoSegmenter_OpeningFcn, ...
                   'gui_OutputFcn',  @autoSegmenter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%%








% --- Executes just before autoSegmenter is made visible.
function autoSegmenter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autoSegmenter (see VARARGIN)

% Choose default command line output for autoSegmenter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global im_default
if strcmp(get(hObject,'Visible'),'off')
    if (ispc == 1)        
        im_default = imread('..\..\DRaCALAtron\Images\countChocula.jpg');
    elseif (isunix == 1)
        im_default = imread('../../DRaCALAtron/Images/countChocula.jpg');
    else
        im_default = imread('coins.png');
    end    
    imagesc(im_default), axis image, axis off;    
end
% UIWAIT makes autoSegmenter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = autoSegmenter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
