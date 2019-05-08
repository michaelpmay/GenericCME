classdef Histogram
  %HISTOGRAM Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    data
  end
  properties (Hidden)
    histogram
  end
  methods
    function obj = Histogram(data)
      %HISTOGRAM Construct an instance of this class
      %   Detailed explanation goes here
      obj.histogram = histogram(data.x);
    end
    
    function outputArg = method1(obj,inputArg)
      %METHOD1 Summary of this method goes here
      %   Detailed explanation goes here
      outputArg = obj.Property1 + inputArg;
    end
  end
end

