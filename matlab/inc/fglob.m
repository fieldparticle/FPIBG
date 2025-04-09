function [fname] = fglob(template, bcase)
% function [fname] = fglob(template, bcase)
%
% fglob: interprets regular expression filename template(s) and
%        returns a cell array of file names in the current directory
%        that match the template(s).
%
% template : string or cell array with regular expression template for file names
% bcase    : (optional) ignore case if set to ~= 0. Default is 0.
% fname    : column cell array with file names that match the template
%
% NOTE: 
%   - the matching is case sensitive by default.
%   - when the regular expression is part of a format string in *printf functions,
%     it must be escaped with '\'.
% 
% REGULAR EXPRESSIONS (see also 'help regexp'):
% Regular expressions can contain any of the following MATCHING operators:
%
%      .     Matches any character
%      []    List operator: matches any character contained within
%            the brackets, e.g. [abc]
%      -     Range operator: used in lists to specify a range of
%            characters, e.g. [a-d] or [0-9]
%      [^]   Matches any character not contained in the list
%      \w    A word character; same as [a-z_A-Z0-9]
%      \W    Not a word character; same as [^a-z_A-Z0-9]
%      \d    A digit; same as [0-9]
%      \D    Not a digit; same as [^0-9]
%      \s    Whitespace; same as [ \t\r\n\f\v]
%      \S    Not whitespace; same as [^ \t\r\n\f\v]
%
% Regular expressions can contain GROUPING and ANCHORING operators:
% (anchoring isn't relevant for file name matching)
%
%      ()    Group subexpression
%      |     Alternation opterator: match subexpression before or after the |
%      ^     Match expression at the start of string
%      $     Match expression at the end of string
%      \<    Match expression at the start of a word
%      \>    Match expression at the end of a word
%
% Regular expressions can contains the following REPETITION operators:
%
%      *     Match zero or more times
%      +     Match one or more times
%      ?     Match zero or one times
%      {n,m} Match between n and m times
%
%    To match a character that is a regular expression operator, escape that
%    character with a '\'.  For example '.' matches any character, so to match
%    a '.' specifically, use '\.' in the regular expression.
%
%
% EXAMPLES
%    'ca_[0-9][0-9]\.fits' or 'ca_[0-9]{2,2}\.fits'
%          matches ca_00.fits, ca_01.fits, ..., ca_21.fits, ...
%
%    'c[ab]_0\.fits'
%          matches ca_0.fits and cb_0.fits
%
%    'c.?_0\.fits'
%          matches c_0.fits, c1_0.fits, ca_0.fits, etc.
%
%    'c([ab])|([1-3])_0\.fits'
%          matches ca_0.fits, cb_0.fits, c1_0.fits, c2_0.fits, and c3_0.fits
%
% the possibilities are endless ...
%

% This software is in the Public Domain
% 
% Version 1.0
% Author: Ulf Griesmann; NIST; April 2012
% - ensure that file names are unique. UG, May 2016
% Status: A-OK
% ---------------------------------------------------------

    % check arguments
    if nargin < 2, bcase = []; end
    if isempty(bcase), bcase = 0; end

    % turn single input string into cell array
    if ~iscell(template), template = {template}; end;

    % find all files in current directory and convert to a cell array
    fil = dir('.');
    fil = fil(~cat(1,fil.isdir));  % array of structures with file info
    fil = {fil.name};              % cell array of file names

    fname = {};  
  
    % check each template
    for k = 1:length(template)

        % find which files in fil match the template (returns cell array of cell arrays)
        if bcase
            mfil = cellfun(@(x)regexpi(x,template{k},'match'), fil, 'UniformOutput',0);
        else
            mfil = cellfun(@(x)regexp(x,template{k},'match'), fil, 'UniformOutput',0);
        end
        
        % collect the matching names
        fname = [fname; [mfil{:}]'];

    end

    fname = unique(fname);
    
end
