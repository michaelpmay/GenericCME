classdef GenericData
  % stores state and time data and has a few simple plot methods
  properties
    time
    state
    meta
  end
  methods
    function obj=GenericData(varargin)
      if nargin==0
        
      elseif nargin==2
        obj.time=varargin{1};
        obj.state=varargin{2};
      else
        obj.time=varargin{1};
      	obj.state=varargin{2};
        obj.meta=varargin{3};
      end
    end
    function drawTrajectory(obj)
      stairs(obj.time,obj.state');
    end
    function plotHistogram(obj,bins)
      [h,b]=hist(obj.state,bins);
      barPlot=bar(b-.5,h);%center indivitual bars on the axis
      barPlot.BarWidth=.9;
      barPlot.EdgeAlpha=0;
    end
    function print(obj)
    end
    function save(obj,filename)
      save([pwd,'genericDataFiles'],filename,obj);
    end
  end
end
