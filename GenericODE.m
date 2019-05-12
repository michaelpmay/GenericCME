classdef GenericODE < AbstractODE & GenericCME
  properties
    time=[]
    initialState=[]
    stoichMatrix=[]
    rxnRate=@(x,t,u)[]
  end
  methods Private
    function data=runTrajectory(obj)
      % runtrajectory numerically solves for the ode using ode45 and appends
      % some metadata from the ode45 solver to data.meta
      R=@(t,x)obj.stoichMatrix*obj.rxnRate(x,t);%R=s*r
      odeData=ode23s(R,obj.time,obj.initialState);
      data=GenericData(odeData.x,odeData.y);
    end
    function data=appendMetaData(obj,data)
      data.meta.solver=class(obj);
      data.meta.timeStamp=datetime;
      data.meta.time=obj.time;
      data.meta.initialState=obj.initialState;
      data.meta.rxnRate=obj.rxnRate;
      data.meta.stoichMatrix=obj.stoichMatrix;
      data.meta.details=[];
    end
  end
end