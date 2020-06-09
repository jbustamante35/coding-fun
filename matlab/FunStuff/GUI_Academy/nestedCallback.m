% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
maxval = get(hObject,'Max');  
sval = get(hObject,'Value');  
diffMax = maxval - sval;   
data = get(hObject,'UserData');
data.val = sval;
data.diffMax = diffMax;
% Store data in UserData of slider
set(hObject,'UserData',data);