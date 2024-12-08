function [results] = applyInverseFilter(GIFparams, speechData, timeMarks, C)
% Inverse Filtering
% C.gif.method can be one of the following candidates: 'Original-IAIF',
% results.glotFlow
% results.glotFlowD
% results.numIters if IOP-IAIF

	if strcmp(C.gif.method,'Original-IAIF')
	    [results.glotFlow,...
	     results.glotFlowD] = iaif_olaf(...
	     						speechData.speech,...
	                            speechData.fs,...
	                            GIFparams.VTorder,...
	                            GIFparams.GSorder,...
	                            GIFparams.LipRad,...
	                            GIFparams.HPflag,...
	                            timeMarks.analysisFramesSamples...
	                            );
	elseif strcmp(C.gif.method,'IOP-IAIF')
	    [results.glotFlow,...
	     results.glotFlowD, ~, ~, ~,...
	     results.numIters] = iop_iaif_olaf(...
	     						speechData.speech,...
                                speechData.fs,...
                                GIFparams.VTorder,...
                                GIFparams.GSorder,...
                                GIFparams.LipRad,...
                                GIFparams.HPflag,...
                                timeMarks.analysisFramesSamples...
                                );
	elseif strcmp(C.gif.method,'GFM-IAIF')
	    [results.glotFlow,...
	     results.glotFlowD] = gfmiaif_olaf(...
	     						speechData.speech,...
                                speechData.fs,...
                                GIFparams.VTorder,...
                                GIFparams.GSorder,...
                                GIFparams.LipRad,...
                                timeMarks.analysisFramesSamples...
                                );
	elseif contains(C.gif.method,'QCP')    
	     [results.glotFlow,...
	      results.glotFlowD] = qcp_olaf(...
	      					speechData.speech,...
	                        speechData.fs,...
	                        GIFparams.VTorder,...
	                        GIFparams.GSorder,...
	                        GIFparams.LipRad,...
	                        GIFparams.DQ,...
	                        GIFparams.PQ,...
	                        GIFparams.RQ,...
	                        'causal',...
	                        GIFparams.STcompensation,...
	                        timeMarks.analysisFramesSamples,...
	                        timeMarks.gcisSamples...
	                        );
	end
end