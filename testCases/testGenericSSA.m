clear all
X=GenericSSA;
X.time=[0 100];
X.stoichMatrix=[-1   0 
                 1, -1];
X.initialState=[100;0];
X.rxnRate=@(x,t,u)[1*(x(1)) ; .05*x(2)];
data=X.run()
figure()
data.plotTrajectory()


X.stoichMatrix=[-1   0  1;
                 1, -1  0];
X.rxnRate=@(x,t,u)[1*(x(1)) ; .05*x(2);1];            
X.time=linspace(0,100)
data=X.run()
figure()
data.plotTrajectory()