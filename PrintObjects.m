classdef PrintObjects
  methods
    function saveTo(obj,directory)      
      if ~(exist(directory,'dir'))
        mkdir(directory)
      end
      randomIntegerString=['_',strrep((num2str(randi(9,1,8))),' ','')];
      timeStamp=replace(replace(replace(datestr(now),'-',''),':',''),' ','');
      save([directory,'/',obj.generateFileName],'obj')
    end
    function decoration=generateFileDecoration(obj)
      plainStamp=datestr(now);
      newStamp=replace(plainStamp,'-','');
      newStamp=replace(newStamp,':','');
      timeStamp=replace(newStamp,' ','_');
      randomIntegerString=['_',strrep((num2str(randi(9,1,8))),' ','')];
      decoration=[timeStamp,randomIntegerString];
    end
    function fileName=generateFileName(obj)
      fileName=[class(obj),obj.generateFileDecoration]
    end
    function printTo(obj,directory)
      %todo
    end
  end
end