classdef PrintObjects
  methods
    function saveTo(obj,directory)      
      if ~(exist(directory,'dir'))
        mkdir(directory)
      end
      randomIntegerString=['_',strrep((num2str(randi(9,1,8))),' ','')]
      timeStamp=replace(datestr(date),'-','')
      save([directory,'/',class(obj),timeStamp,randomIntegerString],'obj')
    end
    function printTo(obj,directory)
      %todo
    end
  end
end