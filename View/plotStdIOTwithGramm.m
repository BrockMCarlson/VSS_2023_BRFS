function plotStdIOTwithGramm(forGramm,IDX)



close all
sdftm = IDX.allV1(1).TM;
% Gramm plots for vis repeated trajectories
clear g
g=gramm('x',sdftm,'y',forGramm.SDF.SDF_singleTrials,...
    'color',forGramm.SDF.trlLabel_1, 'subset',...
   ~strcmp(forGramm.SDF.depthLabel_1, 'O'));
g.facet_grid([],forGramm.SDF.trlLabel_1)

g.stat_summary('bin_in',500);
g.axe_property('YLim',[-.05 2]);
g.axe_property('XLim',[-.05 .79]);
g.set_title('Interocular Transfer of Adaptation: Full stimulus timecourse')
g.set_names('column','Stimulus','x','Time (s) from onset',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
figure('Position',[80 58 1757 878]);
g.draw();

%h plotting
sdftm = IDX.allV1(1).TM;
clear h
h(1,1)=gramm('x',sdftm,'y',forGramm.SDF.SDF_singleTrials,...
    'color',forGramm.SDF.trlLabel_1, 'subset',...
   (strcmp(forGramm.SDF.trlLabel_1, 'A. Prefered eye monocular') |...
   strcmp(forGramm.SDF.trlLabel_1, 'D. Prefered eye adapted'))  &...
   ~strcmp(forGramm.SDF.depthLabel_1, 'O') ...
   );

h.stat_summary('bin_in',500);
h.axe_property('YLim',[-.05 2]);
h.axe_property('XLim',[-.05 .79]);
h.set_title('Monocular vs Adapted')
h.set_names('x','Time (s) from onset',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
figure('Position',[80 58 1757 878]);
h.draw();


%i plotting
sdftm = IDX.allV1(1).TM;
clear i
i(1,1)=gramm('x',sdftm,'y',forGramm.SDF.SDF_singleTrials,...
    'color',forGramm.SDF.trlLabel_1, 'subset',...
   (strcmp(forGramm.SDF.trlLabel_1, 'C. Null eye monocular') |...
   strcmp(forGramm.SDF.trlLabel_1, 'B. Null eye adapted'))  &...
   ~strcmp(forGramm.SDF.depthLabel_1, 'O')...
   );

i.stat_summary('bin_in',500);
i.axe_property('YLim',[-.05 2]);
i.axe_property('XLim',[-.05 .79]);
i.set_title('Monocular vs Adapted')
i.set_names('x','Time (s) from onset',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
figure('Position',[80 58 1757 878]);
i.draw();

%% Laminar breakdown
clear j
j=gramm('x',sdftm,'y',forGramm.SDF.SDF_singleTrials,...
    'color',forGramm.SDF.trlLabel_1, 'subset',...
   (strcmp(forGramm.SDF.trlLabel_1, 'A. Prefered eye monocular') |...
   strcmp(forGramm.SDF.trlLabel_1, 'D. Prefered eye adapted'))  &...
   ~strcmp(forGramm.SDF.depthLabel_1, 'O') & ...
   ~strcmp(forGramm.SDF.monkeyLabel, 'J'));
j.facet_grid(forGramm.SDF.depthLabel_1,[])

j.stat_summary('bin_in',500);
j.axe_property('YLim',[-.05 2]);
j.axe_property('XLim',[-.05 .79]);
j.set_title('Onset vs adapted: Monocular preferred eye')
j.set_names('row','Laminar Compartment','x','Time (s) from onset',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
j.set_order_options("row",0)
figure('Position',[80 58 1757 878]);
j.draw();


clear k
k=gramm('x',sdftm,'y',forGramm.SDF.SDF_singleTrials,...
    'color',forGramm.SDF.trlLabel_1, 'subset',...
   (strcmp(forGramm.SDF.trlLabel_1, 'C. Null eye monocular') |...
   strcmp(forGramm.SDF.trlLabel_1, 'B. Null eye adapted'))  &...
   ~strcmp(forGramm.SDF.depthLabel_1, 'O') & ...
   ~strcmp(forGramm.SDF.monkeyLabel, 'J'));
k.facet_grid(forGramm.SDF.depthLabel_1,[])

k.stat_summary('bin_in',500);
k.axe_property('YLim',[-.05 2]);
k.axe_property('XLim',[-.05 .79]);
k.set_title('Null eye - floor effect observed')
k.set_names('row','Laminar Compartment','x','Time (s) from onset',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
k.set_order_options("row",0)
figure('Position',[80 58 1757 878]);
k.draw();

%% Plot Response values (so I don't have to in JASP tonight)
clear l
l=gramm('x',forGramm.RESP.trlLabel_2,'y',forGramm.RESP.RESPbinVal,...
    'color',forGramm.RESP.trlLabel_2, 'subset',...
   (strcmp(forGramm.RESP.trlLabel_2, 'A. Prefered eye monocular') |...
   strcmp(forGramm.RESP.trlLabel_2, 'D. Prefered eye adapted'))  &...
   ~strcmp(forGramm.RESP.depthLabel_2, 'O') &...
   strcmp(forGramm.RESP.RESPbinLabel, 'Sustained') &...
   ~strcmp(forGramm.RESP.monkeyLabel_2, 'J'));
% l.facet_grid(forGramm.RESP.depthLabel_2,[])


l.geom_jitter()
l.stat_violin('half',true,'width',.3,'fill','transparent')
l.stat_boxplot()
% l.axe_property('YLim',[-2 5]);
l.set_title('Prefered eye')
l.set_names('x','Stimulus',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
l.set_order_options("row",0)
figure('Position',[680 89 560 889]);
l.draw();

% with laminar subdivision
clear m
m=gramm('x',forGramm.RESP.trlLabel_2,'y',forGramm.RESP.RESPbinVal,...
    'color',forGramm.RESP.trlLabel_2, 'subset',...
   (strcmp(forGramm.RESP.trlLabel_2, 'A. Prefered eye monocular') |...
   strcmp(forGramm.RESP.trlLabel_2, 'D. Prefered eye adapted'))  &...
   ~strcmp(forGramm.RESP.depthLabel_2, 'O') &...
   strcmp(forGramm.RESP.RESPbinLabel, 'Sustained') &...
    ~strcmp(forGramm.RESP.monkeyLabel_2, 'J'));
m.facet_grid(forGramm.RESP.depthLabel_2,[])


m.geom_jitter()
m.stat_violin('half',true,'width',.3,'fill','transparent')
m.stat_boxplot()
% m.axe_property('YLim',[-2 5]);
m.set_title('Prefered eye laminar breakdown')
m.set_names('row','Laminar Compartment',...
    'x','Stimulus',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
m.set_order_options("row",0)
figure('Position',[680 89 560 889]);
m.draw();

%%%%%%%%%%%
% Null eye RESP
clear n
n=gramm('x',forGramm.RESP.trlLabel_2,'y',forGramm.RESP.RESPbinVal,...
    'color',forGramm.RESP.trlLabel_2, 'subset',...
   (strcmp(forGramm.RESP.trlLabel_2, 'C. Null eye monocular') |...
   strcmp(forGramm.RESP.trlLabel_2, 'B. Null eye adapted'))  &...
   ~strcmp(forGramm.RESP.depthLabel_2, 'O') &...
   strcmp(forGramm.RESP.RESPbinLabel, 'Sustained') &...
   ~strcmp(forGramm.RESP.monkeyLabel_2, 'J'));
% n.facet_grid(forGramm.RESP.depthLabel_2,[])


n.geom_jitter()
n.stat_violin('half',true,'width',.3,'fill','transparent')
n.stat_boxplot()
% n.axe_property('YLim',[-2 5]);
n.set_title('Null eye avg')
n.set_names('x','Stimulus',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
% n.set_order_options('color',0)
figure('Position',[680 89 560 889]);
n.draw();

% with laminar subdivision
clear o
o=gramm('x',forGramm.RESP.trlLabel_2,'y',forGramm.RESP.RESPbinVal,...
    'color',forGramm.RESP.trlLabel_2, 'subset',...
   (strcmp(forGramm.RESP.trlLabel_2, 'C. Null eye monocular') |...
   strcmp(forGramm.RESP.trlLabel_2, 'B. Null eye adapted'))  &...
   ~strcmp(forGramm.RESP.depthLabel_2, 'O') &...
   strcmp(forGramm.RESP.RESPbinLabel, 'Sustained') &...
    ~strcmp(forGramm.RESP.monkeyLabel_2, 'J'));
o.facet_grid(forGramm.RESP.depthLabel_2,[])


o.geom_jitter()
o.stat_violin('half',true,'width',.3,'fill','transparent')
o.stat_boxplot()
% o.axe_property('YLim',[-2 5]);
o.set_title('Null eye laminar breakdown')
o.set_names('row','Laminar Compartment',...
    'x','Stimulus',...
    'y','MUA response, in z-scored change from baseline',...
    'color','Stimulus')
o.set_order_options("row",0,'color',0)
figure('Position',[680 89 560 889]);
o.draw();
%% Save all the figs
global OUTDIR_PLOT  
cd(OUTDIR_PLOT)
figNameList = {'RESP_nullEye_laminar','RESP_nullEye_avg','RESP_prefEye_laminar','RESP_prefEye_avg','NullEye_Laminar','PrefEye_Laminar','NullEye_Avg','PrefEye_Avg','fullTimeCourse'};

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

