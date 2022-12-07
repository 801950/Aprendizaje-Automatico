close all;
%% Regresión logísitica básica
data = load('exam_data.txt');
y = data(:, 3);
N = length(y);
X = data(:, [1, 2]); 

plotData(X, y);
xlabel('Exam 1 score')
ylabel('Exam 2 score')
legend('Admitted', 'Not admitted')