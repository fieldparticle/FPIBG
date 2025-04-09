function PlotSave(obj, FileName)
    fprintf('Saving Plot: %s.\r\n',FileName);
    export_fig(FileName,'-png');
end