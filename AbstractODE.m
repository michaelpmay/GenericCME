classdef (Abstract) AbstractODE
  properties (Abstract)
    time
    initialState
    rxnRate
    stoichMatrix
  end
  methods (Abstract)
  end
end