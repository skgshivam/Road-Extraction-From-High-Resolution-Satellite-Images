function varargout = GU12(varargin)
% GU12 MATLAB code for GU12.fig
%      GU12, by itself, creates a new GU12 or raises the existing
%      singleton*.
%
%      H = GU12 returns the handle to a new GU12 or the handle to
%      the existing singleton*.
%
%      GU12('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GU12.M with the given input arguments.
%
%      GU12('Property','Value',...) creates a new GU12 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GU12_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GU12_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GU12

% Last Modified by GUIDE v2.5 11-Dec-2018 12:46:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GU12_OpeningFcn, ...
                   'gui_OutputFcn',  @GU12_OutputFcn, ...
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


% --- Executes just before GU12 is made visible.
function GU12_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GU12 (see VARARGIN)

% Choose default command line output for GU12
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GU12 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GU12_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,~] = uigetfile('*.png');
filename=file;
setappdata(0,'filename',filename);
I=imread(filename);
axes(handles.axes1);
imshow(I);
setappdata(0,'originalimage',I)
%setappdata(0,'filename',I);
%plot(handles.axes1,'I')

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(0,'originalimage');
J=rgb2gray(I);
setappdata(0,'grayscale',J);
axes(handles.axes2);
imshow(J);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(~, ~, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%balck and white
J=getappdata(0,'grayscale');
K=imadjust(J,[0.5 0.9],[]); 
level = graythresh(K);  
L=im2bw(K,level);
setappdata(0,'blacknwhite',L);
axes(handles.axes2);
imshow(L);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(~, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% median filtering
L=getappdata(0,'blacknwhite');
B = medfilt2(L);
setappdata(0,'medianfiltered',B);
axes(handles.axes2);
imshow(B);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(~, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% removing connected components
B=getappdata(0,'medianfiltered');
im = bwareaopen(B,10000);
im3 = bwmorph(im, 'majority');
im=im3;
se=strel('disk',2);
im1=imclose(im,se);
im=im1;
setappdata(0,'close1',im);
axes(handles.axes2);
imshow(im);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(~, ~, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%closing
im=getappdata(0,'close1');
BW = bwmorph(im,'remove');
setappdata(0,'removed',BW);
axes(handles.axes2);
imshow(BW);


% --- Executes on button press in pushbutton8.



% --- Executes on button press in pushbutton9.
function pushbutton8_Callback(~, ~, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BW=getappdata(0,'removed');
BW1 = edge(BW,'sobel');
setappdata(0,'edge',BW1);
axes(handles.axes2);
imshow(BW1);


function pushbutton9_Callback(~, ~, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BW=getappdata(0,'edge');
se = ones(2,3);
closeBW=imclose(BW,se);
setappdata(0,'close2',BW);
axes(handles.axes2);
imshow(closeBW);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BW=getappdata(0,'close2');
J=getappdata(0,'grayscale');
H = vision.AlphaBlender;
J = im2single(J);
BW1 = im2single(BW);
Y = step(H,J,BW1);
setappdata(0,'edge2',Y);
axes(handles.axes2);
imshow(Y);





% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4
axes(hObject)
imshow("r2.jpg");



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
