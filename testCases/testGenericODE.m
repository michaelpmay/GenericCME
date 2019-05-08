X=GenericODE
X.time=linspace(0,5,100)
X.initialState=[5 5]
X.rxnRate=@(x,t)[5*x(1)^2;x(2)]
X.stoichMatrix=[-1 1;0 -1]
data=X.run()
data.plotTrajectory()