classdef GenericSSA < AbstractSSA & GenericCME
  properties
    time=[]
    initialState=[]
    stoichMatrix=[]
    rxnRate=@(x,t,u)[]
  end
  methods Private
    function data=run(obj)
      data=obj.runTrajectory();
      data=obj.formatTrajectory(data)
      data=obj.appendMetaData(data);          
    end
    
    function [outData]=runTrajectory(obj)
      [state,time]=obj.getInitialLL();
      [time,state]=obj.integrateSSA(time,state)
      if obj.checkInfinityExitCondition(time)
        obj.trimInfinityExitCondition(time,state)
      end
      outData=GenericData(time.toMLArray,state.toMLArray);
    end
    
    function [time,state]=integrateSSA(obj,time,state)
      waitBar=waitbar(0,'Running SSA');
      while time.getLast<obj.time(end)
        rate=obj.getCumulativeRate(state.getLast,time.getLast);
        time.add(obj.stepToNewTime(time.getLast,rate));
        state.add(obj.stepToNewState(state.getLast,rate));
        waitbar(time.getLast/obj.time(end),waitBar);
      end
      delete(waitBar)
    end
    
    function [x,t]=getInitialLL(obj)
      x=LinkedList(obj.initialState);
      t=LinkedList(obj.time(1));
    end
    
    function x=stepToNewState(obj,x,rate)
      event=find(rate>(rate(end)*rand()),1);
      x=x+obj.stoichMatrix(:,event);
    end
    
    function t=stepToNewTime(obj,t,rate)
      t=t-log(rand)/rate(end);
    end
    
    function rate=getCumulativeRate(obj,x,t)
      rate=obj.rxnRate(x,t);
      rate=cumsum(rate);
    end
    
    function flag=checkInfinityExitCondition(obj,time)
      flag=(time.getLast==inf);
    end
    
    function trimInfinityExitCondition(obj,time,state)
        n=time.length;
        time.set(n,obj.time(end));
        finalState=state.get(n-1);
        state.set(n,finalState);
    end
    
    function flag=isTimeSampled(obj)
      if (length(obj.time)>2)
        flag=1;
      else
        flag=0;
      end
    end
    
    function [data]=parseTrajectory(obj,time,state)
      numTimeElements=length(obj.time);
      parsedStates=zeros(size(state,1),numTimeElements);
      ind=1
      for i=1:numTimeElements
        stepTimeIter=obj.time(i)
        while time(ind)<stepTimeIter
          ind=ind+1
        end
        parsedStates(:,i)=state(:,ind)
      end
      data=GenericData(obj.time,parsedStates);
    end
    
    function [data]=formatTrajectory(obj,data)
      if obj.isTimeSampled()
        data=obj.parseTrajectory(data.time,data.state);
      end
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

