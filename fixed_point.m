function [result] = fixed_point(X0, Es, max_iter, equation, handles)

column = {'Xi' 'Xi+1' 'Es'};
set(handles.table,'ColumnName' , column);

% g = strcat(equation, ' + x');
g = equation;
iterations = max_iter;
Xnow = X0;

tic;
for i = 1:max_iter
    Xnew = double(getfx(g, Xnow));
    
    error = double(abs(Xnew - Xnow));
    
    table(i,:) = [Xnow Xnew error];
    
    if error <= Es
        iterations = i;
        break
    end
    
    Xnow = Xnew;
end

exec_time = toc;
set(handles.execution_time_text, 'String', exec_time);
set(handles.table, 'Data', table);
set(handles.num_iterations_text, 'String', iterations);
result = Xnew;

hold off;

end
