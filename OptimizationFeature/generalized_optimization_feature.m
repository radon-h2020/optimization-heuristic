[hosts_no, microservices_no] = read_tosca_model([pwd, filesep, 'radonblueprintstesting__DecompositionDemo.tosca']);
%[input_table, throughput_table] = read_table('data.csv');
filename_in = [pwd, filesep, 'radonblueprintstesting__DecompositionDemo.tosca'];
filename_out = [pwd, filesep, 'radonblueprintstesting__DecompositionDemo_out.tosca'];
load mynet.mat; % this loads the net object
v = run_ga(hosts_no, microservices_no, net);

x = v(1:hosts_no * microservices_no);
modify_tosca_model(filename_in, filename_out, hosts_no, microservices_no, x)
a=2;

function [hosts_no, microservices_no] = read_tosca_model(filename)
    addJarPaths();
    processor = YamlProcessor();
    tosca = processor.read(filename);
    graph = TopologyGraph(tosca.topology_template);
    
    allNodesStruct = graph.getNodes();
    allNodes = fieldnames(allNodesStruct);
    dockerEngineNodes = allNodes(startsWith(allNodes, 'DockerEngine'));
    dockerApplicationNodes = allNodes(startsWith(allNodes, 'DockerApplication'));
    hosts_no = length(dockerEngineNodes);
    microservices_no = length(dockerApplicationNodes);
    a=2;
end

function z=ga_objective(v,hosts_no, microservices_no, net)
    objective_without_constant_terms = zeros(1, hosts_no * microservices_no + hosts_no);
    for i=1: hosts_no
        objective_without_constant_terms(hosts_no * microservices_no + i) = 1;
    end
    v  = round(v); %% UGLY       
    z = sum(objective_without_constant_terms .* v);
    
    ntypes = net.inputs{1}.size; % number of microservice types
    
    %%% ONLY TO FIX IS THE TYPE VARIABLE
    type = 1:microservices_no; % this has to be changed with the actual mapping from the microservice i to its type based on the TOSCA model. The type is a number between 1 and 6, assuming that 6 is the number of typs in Ahmad's NN input vector. 
    for j=1:hosts_no
        vhostj = v(((j-1)*microservices_no+1):(j*microservices_no));        
        allocation_on_host_j = zeros(1,ntypes);
        for i=1:microservices_no
            ti = type(i); % the type vector is somethi
            xij = vhostj(i);
            if xij == 1
                allocation_on_host_j(ti) = allocation_on_host_j(ti) + 1;
            end
        end
        %allocation_on_host_j
        fj = net(allocation_on_host_j(:));
        z = z - fj;
    end
end

function v = run_ga(hosts_no, microservices_no,net)
    b = zeros(1,hosts_no+1);
    beq = zeros(1, microservices_no);
    A = zeros(hosts_no+1, hosts_no * microservices_no + hosts_no);
    Aeq = zeros(microservices_no, hosts_no * microservices_no + hosts_no);
    total_variables_no = hosts_no * microservices_no + hosts_no;
    
    %set the variables to be integers
    intcon = 1:total_variables_no;
    
    %set the value of b (and beq)
    b(1) = -1;
    for i=2:hosts_no+1
        b(i) = 0;
    end
    for i=1: microservices_no
        beq(i) = 1;
    end
    
    %set the values of A
    B=4;
    %Set the value of the first row (i.e. objective >=1)
    for current_host = 1: hosts_no
        A(1,hosts_no * microservices_no +current_host) = -1;
    end
    %Set the values of the rest of the rows
    for current_host = 2: hosts_no+1
        for current_microservice = 1: microservices_no
            A(current_host, (current_host-2)*microservices_no+current_microservice) = 1;
        end
        A(current_host, hosts_no * microservices_no +current_host-1) = -B;
    end
    
    %set the values of Aeq
    for current_microservice = 1: microservices_no
        for current_host = 1: hosts_no
            Aeq(current_microservice, (current_host-1)*microservices_no+current_microservice) = 1;
        end
    end
    options = optimoptions('ga','Display','iter','MaxStallGenerations',10);
    lb = zeros(size(intcon));
    ub = ones(size(intcon));
    [v,fval] = ga(@(v)ga_objective(v,hosts_no, microservices_no, net),total_variables_no,A,b,Aeq,beq,lb,ub,[],[], options);
    v = round(v); % UGLY 
    a=2;
end

function run_linear_program(hosts_no, microservices_no)
    throughput_array = run_neural_network(hosts_no);
    objective_without_constant_terms = zeros(1, hosts_no * microservices_no + hosts_no);
    b = zeros(1,hosts_no+1);
    beq = zeros(1, microservices_no);
    A = zeros(hosts_no+1, hosts_no * microservices_no + hosts_no);
    Aeq = zeros(microservices_no, hosts_no * microservices_no + hosts_no);
    total_variables_no = hosts_no * microservices_no + hosts_no;
    
    %set the values of the objective without considering the constant terms
    for i=1: hosts_no
        objective_without_constant_terms(hosts_no * microservices_no + i) = 1;
    end
    
    %set the variables to be integers
    intcon = 1:total_variables_no;
    
    %set the value of b (and beq)
    b(1) = -1;
    for i=2:hosts_no+1
        b(i) = 0;
    end
    for i=1: microservices_no
        beq(i) = 1;
    end
    
    %set the values of A
    B=4;
    %Set the value of the first row (i.e. objective >=1)
    for current_host = 1: hosts_no
        A(1,hosts_no * microservices_no +current_host) = -1;
    end
    %Set the values of the rest of the rows
    for current_host = 2: hosts_no+1
        for current_microservice = 1: microservices_no
            A(current_host, (current_host-2)*microservices_no+current_microservice) = 1;
        end
        A(current_host, hosts_no * microservices_no +current_host-1) = -B;
    end
    
    %set the values of Aeq
    for current_microservice = 1: microservices_no
        for current_host = 1: hosts_no
            Aeq(current_microservice, (current_host-1)*microservices_no+current_microservice) = 1;
        end
    end
    v = intlinprog(objective_without_constant_terms,intcon,A,b,Aeq,beq);
    a=2;
end

function modify_tosca_model(filename_in, filename_out, hosts_no, microservices_no, ga_solution)
    addJarPaths();
    processor = YamlProcessor();
    tosca = processor.read(filename_in);
    graph = TopologyGraph(tosca.topology_template);

    allNodesStruct = graph.getNodes();
    allNodes = fieldnames(allNodesStruct);
    a=2
    
    for current_host = 1: hosts_no
        for current_microservice = 1: microservices_no
            applicationNode = graph.getNode('DockerApplication_' +string(current_microservice-1));
            ga_solution_index = (current_host-1)*microservices_no + current_microservice;
            engineNode = graph.getNode('DockerEngine_' +string(ga_solution(ga_solution_index)));
            hostedOnRelationshipName = generateRelationshipName('HostedOn', graph);
            hostedOnRelationship = HostedOn(hostedOnRelationshipName);
            graph.addRelationship(hostedOnRelationship, applicationNode, engineNode);
        end
    end

    tosca.topology_template = graph.transformIntoTemplate();
    processor.write(tosca, filename_out);
end

