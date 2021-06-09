%  f=[5;10;3];
%  a=2;
% intcon = 1;
% intcon = 2;
% intcon = 3;
% A = [-1,0,-1;
%     0,-1,-1;
%     -1,0,-1;
%     -1,0,-1;
%     0,-1,0;
%     1,0,0;
%     0,1,0;
%     0,0,1];
% b=[-1,-1,-1,-1,-1,1,1,1];

%x = intlinprog(f,intcon,A,b)

% tic;
% generate_random_constraints();
% toc;

%[selected_sets, elements_by_set] = run_algorithm();
%modify_tosca_model([pwd, filesep, 'test_model.tosca']);
modify_tosca_model([pwd, filesep, 'model_In.tosca'], [pwd, filesep, 'model_Out.tosca']);

function [selected_sets, elements_by_set] = run_algorithm()
    T1 = readtable('target_Test.csv');
    throughput_table = table2array(T1);
    T2 = readtable('input_Test.csv');
    input_table = table2array(T2);
    interference_table = compute_interference_table(throughput_table, input_table);
    A=generate_A(input_table);
    set_matrix = A.';
    tic
%     HEURISTIC
    [selected_sets, elements_by_set] = greedy_set_cover(interference_table, set_matrix);
    disp(selected_sets)
    for i=1:length(elements_by_set)
        disp(elements_by_set(i).indexes)
    end

%     EXACT
%     experiments = length(throughput_table);
%     b = ones([1, 24]);
%     intcon = 1:experiments;
%     f = throughput_table;
%     reshape(f,1,[]);
%     x = intlinprog(f,intcon,A,b);
%     toc

end

function interference_table = compute_interference_table(throughput_table, input_table)
interference_table = [];
    throughput1 = throughput_table(1,1);
    throughput2 = throughput_table(2,1);
    throughput3 = throughput_table(3,1);
    throughput4 = throughput_table(4,1);
    throughput5 = throughput_table(5,1);
    throughput6 = throughput_table(6,1);
    for i=1:length(throughput_table)
        cell_value1 = input_table(i,1);
        cell_value2 = input_table(i,2);
        cell_value3 = input_table(i,3);
        cell_value4 = input_table(i,4);
        cell_value5 = input_table(i,5);
        cell_value6 = input_table(i,6);
        interference = throughput_table(i) / (cell_value1 * throughput1 + cell_value2 * throughput2 + cell_value3 * throughput3 + cell_value4 * throughput4 + cell_value5 * throughput5 + cell_value6 * throughput6);
        interference_table(end+1) = interference;
    end
end


function generate_random_constraints()
    variables_n = 30;
    constraints_n = 30;
    
    fileID = fopen('random_constraints.txt','w');
    
    fprintf(fileID,'f = [');
    for i=1:variables_n
        value=randsample([1:30],1);
        fprintf(fileID,'%s;',num2str(value));
    end
    fprintf(fileID,'];\n\n\n');
    
    fprintf(fileID,'intcon = 1:%s;\n\n\n',num2str(variables_n));
    
    fprintf(fileID,'b = [');
    for j=1:constraints_n
        value=randsample([-1,1],1);
        fprintf(fileID,'%s',num2str(value));
        if j==constraints_n
            fprintf(fileID,'];\n\n\n');
        else
            fprintf(fileID,',');
        end
    end
    
    fprintf(fileID,'A = [');
    for j=1:constraints_n
        for i=1:variables_n
            value=randi([0 1]);
            fprintf(fileID,'%s',num2str(value));
            if i==variables_n
                fprintf(fileID,';\n');
            else
                fprintf(fileID,',');
            end
        end
    end
    fprintf(fileID,'];');
    fclose(fileID);
end

function f=generate_f(interference_table)
    f = interference_table
end


function A=generate_A(input_table)
    %A = zeros(24, 1)
    A = zeros(24, length(input_table));
    for j=1:6
        %for i=1:1
        for i=1:length(input_table)
            line = input_table(i,:);
            if input_table(i,j) >= 1
                A(4*(j-1)+1,i) = 1;
            end
            if input_table(i,j) >= 2
                A(4*(j-1)+2,i) = 1;
            end
            if input_table(i,j) >= 3
                A(4*(j-1)+3,i) = 1;
            end
            if input_table(i,j) >= 4
                A(4*(j-1)+4,i) = 1;
            end
        end
    end
end


function [selected_sets, elements_by_set] = greedy_set_cover(set_weights, set_matrix)
    sets_n = length(set_weights);
    elements_n = size(set_matrix, 2);
    elements = zeros([1 elements_n]);
    for j=1:elements_n
        elements(j) = j;
    end
    selected_sets = [];
    elements_by_set = [];
    while ~isempty(elements)
        effectiveness = zeros([1 sets_n]);
        best_set = -1;
        best_effectiveness = 0;
        for i=1:sets_n
            set_weight = set_weights(i);
            row_elements = set_matrix(i,:);
            set_elements = [];
            for j=1:elements_n
                if row_elements(j)==1
                    set_elements(end+1) = j;
                end
            end
            uncovered_elements = intersect(set_elements, elements);
            uncovered_size = length(intersect(set_elements, elements));
            set_effectiveness = uncovered_size / set_weight;
            effectiveness(i) = set_effectiveness;
            if set_effectiveness > best_effectiveness
                best_effectiveness = set_effectiveness;
                best_set = i;
                best_set_elements = set_elements;
                best_uncovered_elements = uncovered_elements;
            end
        end
        selected_sets(end+1) = best_set;
        elements_by_set(end+1).indexes = best_uncovered_elements;
        elements = setdiff(elements, best_set_elements);
    end
end 


function modify_tosca_model(filenameIn, filenameOut)
    addJarPaths();
    processor = YamlProcessor();
    tosca = processor.read(filenameIn);
    graph = TopologyGraph(tosca.topology_template);
    
    [selected_sets, elements_by_set] = run_algorithm();
    runtimeNodesNo = length(selected_sets);
    
%     allNodesStruct = graph.getNodes();
%     allNodes = fieldnames(allNodesStruct);
%     computeNodes = allNodes(startsWith(allNodes, 'Compute'));
    
    for i=1:runtimeNodesNo
        runtimeNodeName = generateNodeName('ContainerRuntime_', graph);
        runtimeNode = ContainerRuntime(runtimeNodeName);
        graph.addNode(runtimeNode);
        microservices = elements_by_set(i).indexes;
        for j=1:length(microservices)
            microserviceIndex = microservices(j);
            computeNode = graph.getNode('Compute_' +string(microserviceIndex-1));
            hostedOnRelationshipName = generateRelationshipName('HostedOn', graph);
            hostedOnRelationship = HostedOn(hostedOnRelationshipName);
            graph.addRelationship(hostedOnRelationship, runtimeNode, computeNode);
        end
    end
    tosca.topology_template = graph.transformIntoTemplate();
    processor.write(tosca, filenameOut);
end
