classdef (Abstract) AbstractFSP
  properties (Abstract)
    time
    initialState
    infGenerator
  end
  methods (Abstract)
    run
  end
end