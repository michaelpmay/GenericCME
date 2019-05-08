classdef GenericData
  % stores state and time data and has a few simple plot methods
  properties
    state
    time
    meta
  end
  methods
    function obj=GenericData(time,state)
      obj.state=state;
      obj.time=time;
    end
    function plotTrajectory(obj)
      plot(obj.time,obj.state);
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
