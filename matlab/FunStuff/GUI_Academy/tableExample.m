function tableExample
hFig = figure;
drawnow; %need to get figure rendered
 
%use Yair's createTable to add a javax.swing.JTable
%http://www.mathworks.com/matlabcentral/fileexchange/14225-java-based-data-table
%wrap ceateTable in javaObjectEDT to put the ensuing method calls on the EDT
f = java.awt.Font(java.lang.String('Dialog'),java.awt.Font.PLAIN,14);
headers = {'Selected','File','Analysis Routine','Task Status'};
tbl = javaObjectEDT(createTable(hFig,headers,[],false,'Font',f));
 
%set column 1 to use check boxes and set up a change callback
tbl.setCheckBoxEditor(1);
jtable = javaObjectEDT(tbl.getTable); %get the underlying Java Table. IMPORTANT: we need to put jtable on the EDT
columnModel = javaObjectEDT(jtable.getColumnModel); %now we can now do direct calls safely on jtable
selectColumn = javaObjectEDT(columnModel.getColumn(0));
selectColumnCellEditor = selectColumn.getCellEditor;
chk = javaMethodEDT('getComponent',selectColumnCellEditor);
set(chk,'ItemStateChangedCallback',@chkChange_Callback);
 
%make column three a combo drop down
analysisTable = {'Analysis1';'Analysis2';'Analysis3'};
cb = javaObjectEDT('com.mathworks.mwswing.MJComboBox',analysisTable);
cb.setEditable(false);
cb.setFont(f);
set(cb,'ItemStateChangedCallback',@cbChange_Callback);
editor = javaObjectEDT('javax.swing.DefaultCellEditor',cb);
analysisColumn = javaObjectEDT(columnModel.getColumn(2));
analysisColumn.setCellEditor(editor);
 
%set some column with restrictions
selectColumn.setMaxWidth(100);
analysisColumn.setPreferredWidth(300);
 
%set the data
SELECTED = java.awt.event.ItemEvent.SELECTED;
tbl.setData({false,'file1','Analysis2','Analysis2';...
             true,'file2','Analysis3','Analysis3'});
drawnow;
 
    function cbChange_Callback(src,ev) %#ok
        jRow = jtable.getSelectedRow;
        stateChange = javaMethodEDT('getStateChange',ev);
        if stateChange == SELECTED
            newData = javaMethodEDT('getItem',ev);
            model = jtable.getModel;
            javaMethodEDT('setValueAt',model,newData,jRow,3);
        end %if
    end %cbChange
 
    function chkChange_Callback(src,ev) %#ok
        chkBox = javaMethodEDT('getItem',ev);
        if logical(javaMethodEDT('isSelected',chkBox))
            beep; %put useful code here
        else
            beep;
            pause(0.1)
            beep; %put useful code here
        end %if
    end %chkChange_Callback
 
end %tableExample