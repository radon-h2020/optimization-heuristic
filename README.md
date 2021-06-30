# radon-decomposition-interference


The set_cover.m file contains the implementations for the optimization problem. The user can decide by the function run_algorithm() to either run the exact algorithm which solves the integer linear programming formulation of the set cover problem optimally, or run the heuristic that runs the greedy algorithm to solve the problem approximately but in a more efficient way. 

The interference is computed by the compute_interference_table() method that translates the throughput of a selection.

The method modify_tosca_model() adds the relationships to the corresponding graph of the tosca model.