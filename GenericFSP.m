classdef GenericFSP < AbstractFSP & GenericCME
  properties
    time=[]
    initialState=[]
    infGenerator=[]
  end
    methods Private
    function outData=runTrajectory(obj)
      for i=1:length(obj.time)
        P(:,i)=expm(obj.infGenerator*obj.time(i))*obj.initialState
      end
      outData=GenericData(obj.time,P)
    end
    function data=appendMetaData(obj,data)
      data.meta.solver=class(obj);
      data.meta.timeStamp=date;
      data.meta.time=obj.time;
      data.meta.initialState=obj.initialState;
      data.meta.details=[];
      data.meta.infGenerator=obj.infGenerator;
    end
  end
end