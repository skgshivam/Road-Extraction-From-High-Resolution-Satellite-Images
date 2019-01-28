function varargout = finalgui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @finalgui_OpeningFcn, ...
                   'gui_OutputFcn',  @finalgui_OutputFcn, ...
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

function finalgui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
axes(handles.axes3)
imshow('logo.jpg')

guidata(hObject, handles);

function varargout = finalgui_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function Browse_Callback(hObject, eventdata, handles)

    [filename, pathname] = uigetfile('*.jpg', 'Pick a Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
    filename=strcat(pathname,filename);
    
    I=imread(filename);
    
    axes(handles.axes1);
    imshow(I);
    
    handles.I=I;
    end
    
guidata(hObject, handles);

function pushbutton2_Callback(hObject, eventdata, handles)

    
    I=handles.I;
    J=rgb2gray(I);
    
    
   % imshow(J);
    K=imadjust(J,[0.5 0.9],[]); 
    
    %figure;
    
    %imshow(K);
    %figure,imshow(J);
    title('grayscale image');
    level = graythresh(K);  
    I=im2bw(K,level);     
    
    %figure;
    %imshow(I);
    title('Binary image after thresholding');
    B = medfilt2(I);
    %figure,  
    %imshow(B);
    title('median filtered image');
    im = bwareaopen(B,10000);
    %figure,imshow(im);
    title('removing connected components(pixel <6)');
    BW = bwmorph(im,'remove');
    %figure,imshow(BW);
    title('morphological filtering');
    BW1 = edge(BW,'sobel',0.27);
    %figure,
    %imshow(BW1);
    title('edge detection(sobel)');
    se=strel('disk',2)
    Q=imclose(BW1,se)

    %figure,
    %imshow(Q);
    title("closing")
    b_img_skel = bwmorph(Q, 'skel', 1);

    b_img_spur = bwmorph(b_img_skel, 'spur', Inf);
    %figure('Name', 'Pruning');
    axes(handles.axes2);
    imshow(b_img_spur);
    title("after closing")
    
    handles.BW1=BW1axes(handles.axes2);
guidata(hObject, handles);
    
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function axes6_CreateFcn(hObject, eventdata, handles)

axes(hObject);
imshow('1.jpg')
