function plotLaminarSubtraction(forGramm,IDX)
close all
sdftm = IDX.allV1(1).TM;

%% Laminar breakdown
clear j
j=gramm('x',sdftm,'y',forGramm.subtract.subtract_DE);
j.facet_grid(forGramm.subtract.depthLabel_3,[])

j.stat_summary();
j.axe_property('YLim',[-4 1]);
j.axe_property('XLim',[-.05 .79]);
j.set_title('Subtraction: [adapted - monocular onset]; DE')
j.set_names('row','Laminar Compartment','x','Time (s) from onset',...
    'y','baseline - subtracted MUA response')
j.set_order_options("row",0)
figure('Position',[113 79.4000 1.2776e+03 664]);
j.draw();


clear k
k=gramm('x',sdftm,'y',forGramm.subtract.subtract_NDE);
k.facet_grid(forGramm.subtract.depthLabel_3,[])

k.stat_summary();
k.axe_property('YLim',[-1.5 3]);
k.axe_property('XLim',[-.05 .79]);
k.set_title('Subtraction: [adapted - monocular onset]; NDE')
k.set_names('row','Laminar Compartment','x','Time (s) from onset',...
    'y','baseline - subtracted MUA response')
k.set_order_options("row",0)
figure('Position',[113 79.4000 1.2776e+03 664]);
k.draw();


%% Save all the figs
global OUTDIR_PLOT  
cd(OUTDIR_PLOT)
figNameList = {'NDE_subtract','DE_subtract'};

FolderName = OUTDIR_PLOT;   % Your destination folder
cd(FolderName)
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = figNameList{iFig};
  savefig(FigHandle, strcat(FolderName, FigName, '.fig'));
  saveas(FigHandle, strcat(FolderName, FigName, '.svg'));

end

end

