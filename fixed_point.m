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
    if isnan(Xnew)
        break;
    end
    error = double(abs(Xnew - Xnow));
    
    table(i,:) = [Xnow Xnew error];
    
    if error <= Es
        iterations = i;
        break
    end
    
    Xnow = Xnew;
end

exec_time = toc;
set(handles.extime, 'String', exec_time);
set(handles.table, 'Data', table);
set(handles.itrtaken, 'String', iterations);
result = Xnew;

hold off;

end
