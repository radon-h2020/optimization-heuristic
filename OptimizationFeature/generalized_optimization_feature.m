%[hosts_no, microservices_no] = read_tosca_model([pwd, filesep, 'radonblueprintstesting__DecompositionDemo.tosca']);
%[input_table, throughput_table] = read_table('data.csv');
%single_column_throughputs = get_list_of_single_throughput(microservices_no, input_table, throughput_table);444
%interference_table = get_interference_table(single_column_throughputs, input_table, throughput_table);
%best_input_table_row = get_best_experiment(input_table, throughput_table);
%filename_in = [pwd, filesep, 'radonblueprintstesting__DecompositionDemo.tosca'];
%filename_out = [pwd, filesep, 'radonblueprintstesting__DecompositionDemo_out.tosca'];
%run_linear_program(hosts_no, microservices_no);
load mynet.mat; % this loads the net object

hosts_no=2;
microservices_no = 4;

run_ga(hosts_no, microservices_no, net);
%modify_tosca_model(filename_in, filename_out, best_input_table_row)
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


function [input_table, throughput_table] = read_table(filename)
    T1 = readtable(filename);
    T2 = T1(:,end:end);
    T1 = T1(:,1:end-1);
    input_table = table2array(T1);
    throughput_table = table2array(T2);
    a=2;
end

% %Returns the row where only column_no has value of 1
% function the_row = get_row_for_given_single_column(column_no, input_table)
%     rows_no = height(input_table);
%     columns_no = width(input_table);
%     for row=1:rows_no
%         row_found = 1;
%         for column=1:columns_no
%             if column~=column_no
%                 if input_table(row, column) == 1
%                     row_found = 0;
%                 end
%             else
%                 if input_table(row, column) == 0
%                     row_found = 0;
%                 end
%             end
%         end
%         if row_found==1
%             the_row = row; 
%         end
%     end
% end
% 

% function single_column_throughputs = get_list_of_single_throughput(microservices_no, input_table, throughput_table)
%     single_column_throughputs = [];
%     for microservice_column = 1: microservices_no
%         the_row = get_row_for_given_single_column(microservice_column, input_table);
%         single_column_throughputs(microservice_column) = throughput_table(the_row);
%     end
% end
% 
% %Compute the interference based on the throughput values
% function interference_table = get_interference_table(single_column_throughputs, input_table, throughput_table)
%     interference_table = [];
%     for table_row = 1: height(throughput_table)
%         input = input_table(table_row,:);
%         row_throughput = throughput_table(table_row);
%         denominator_throughput = 0;
%         for column = 1: length(input)
%             if input(column) == 1
%                 denominator_throughput = denominator_throughput + single_column_throughputs(column);
%             end
%         end
%         if denominator_throughput == 0
%             interference_value = row_throughput;
%         else
%             interference_value = row_throughput / denominator_throughput;
%         end
%         interference_table(table_row) = interference_value;
%     end
% end
% 
% function input_table_best_row = get_best_experiment(input_table, throughput_table)
%     best_throughput = 0;
%     best_row = 0;
%     for row = 1: height(input_table)
%         if throughput_table(row) > best_throughput
%             best_throughput = throughput_table(row);
%             best_row = row;
%         end
%     end
%     input_table_best_row = input_table(best_row,:);
% end
% 

function throughput_array = run_neural_network(hosts_no)
    throughput_array = [];

    BestNet=Reg4Jobs_RepresentB_V4_ThroughputRADON_V2FunctionPicards(pwd);
    net=BestNet{1,1};

    input_Test = load('input_Test.csv'); 
    input_Train= load ('input_Train.csv');
    target_Train = load('target_Train.csv');
    target_Test = load('target_Test.csv');

    for server = 1: hosts_no
        x=net(input_Test(server,:)')';
        %x=net(])';
        throughput_array(server) = x;
    end
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

function run_ga(hosts_no, microservices_no,net)
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
    [v,fval] = ga(@(v)ga_objective(v,hosts_no, microservices_no, net),total_variables_no,A,b,Aeq,beq,lb,ub,[],[], options)
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

function modify_tosca_model(filename_in, filename_out, best_row)
    addJarPaths();
    processor = YamlProcessor();
    tosca = processor.read(filename_in);
    graph = TopologyGraph(tosca.topology_template);

    allNodesStruct = graph.getNodes();
    allNodes = fieldnames(allNodesStruct);
    a=2
    
    for i=1:length(best_row)
        applicationNode = graph.getNode('DockerApplication_' +string(i-1));
        engineNode = graph.getNode('DockerEngine_' +string(best_row(i)));
        hostedOnRelationshipName = generateRelationshipName('HostedOn', graph);
        hostedOnRelationship = HostedOn(hostedOnRelationshipName);
        graph.addRelationship(hostedOnRelationship, applicationNode, engineNode);
    end

    tosca.topology_template = graph.transformIntoTemplate();
    processor.write(tosca, filename_out);
end

