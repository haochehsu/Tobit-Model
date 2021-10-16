function [likelihood] = MLE(parameter)

global positive
global negative

negative_part = log(...
    normcdf(...
    -(negative(:, 2) * parameter(1, 1)) / parameter(1, 2)));

positive_part = log(...
    normpdf(...
    positive(:, 1), positive(:, 2) * parameter(1, 1), parameter(1, 2)));

likelihood = - sum(positive_part) - sum(negative_part);
