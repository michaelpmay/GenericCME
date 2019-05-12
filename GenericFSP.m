classdef GenericFSP < AbstractFSP & GenericCME
  properties
    time=[]
    initialState=[]
    infGenerator=[]
  end
  methods Private
    function outData=runTrajectory(obj)
      infGen=sparse(obj.getInfGenerator());
      initialState=sparse(obj.getInitialState());
      maxInd=length(obj.time);
      waitBar=waitbar(0,'Running FSP');
      for i=1:maxInd
        waitbar(i/maxInd,waitBar);
        P(:,i)=expm(infGen*obj.time(i))*initialState;
      end
      outData=GenericData(obj.time,P)
      delete(waitBar)
    end
    function data=appendMetaData(obj,data)
      data.meta.solver=class(obj);
      data.meta.timeStamp=datetime;
      data.meta.time=obj.time;
      data.meta.initialState=obj.initialState;
      data.meta.details=[];
      data.meta.infGenerator=obj.infGenerator;
    end
    function P=getSteadyState(obj)
      [P,d]=eigs(obj.getInfGenerator,1,0);
      P=real(P)./sum(real(P));
    end
    function P=getNullP(obj)
      P=null(obj.getInfGenerator)
    end
    function out=getInfGenerator(obj)
      out=obj.infGenerator;
    end
    function out=getInitialState(obj)
      out=obj.InitialState;
    end
    function outData=formatTrajectory(obj,data)
      outData=data;
    end
  end
end