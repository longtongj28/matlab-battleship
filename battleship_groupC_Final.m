% Battleship: Group C
% Problems:

% Enhancements:
% 1. Ability to choose whatever ship you want to place in whatever order
% 2. Ability to clear board during placement
% 3. Cool images/Characters used throughout code
clc;
clear all;


gameover = 1;
while gameover == 1
clc;
% Introduction
fprintf('Welcome to Matlab Battleship! Before we begin, here''s an introduction on how to play...\n\n')
fprintf( ...
    ['                         ==^==\n' ...
    '                    _____/|#|//___:\n' ...
    '    ________|______/__0__/____0_0_|____/______\n' ...
    '   (     0      0   ,   0   ,   ````   0       )\n' ...
    '~~~~~~~`~~~~`~~`~~~`~~`~~`~~`~~`~~~`~~~~`~~`~`~~~~~~\n\n']);
% Introduction

fprintf('Up to two people can play this game. Each player will choose the placement of their ships on a 10x10 board (Carrier [5 spaces], Battleship [4 spaces],\nDestroyer [3 spaces], Submarine [3 spaces], Patrol Boat [2 spaces]). Your ship can ONLY be placed horizontally or vertically. If you decide to play\nagainst the computer, a random board will be selected for Vladimir, your AI opponent.')
fprintf(' If you choose a coordinate that your opponent''s ship occupies, an\n''x'' will appear to signify a "hit." If no vessel is in that plot of water, an ''o'' will appear on the board to signify a "miss."')
fprintf('\n\nOBJECTIVE: Sink all of the opponent ships before they sink yours.\n\n')
fprintf('Here''s a rundown of the board...\n\n')
fprintf('# = Carrier | @ = Battleship | %% = Destroyer | & = Submarine | $ = Patrol Boat\n\n')
fprintf('You will need to place all five of your ships on the board. First, you will need to place your ship on an x coordinate (a number 1-10), then on a y\ncoordinate (a letter A-J). Once both players have chosen the positions of their ships, Player 1 will start the game.\n\n')
fprintf('Let''s play!\n')

% Select mode
mode = input('Please select game mode: Type (1) for single player mode vs. AI, and (2) for two player mode.\n');
while ~(mode == 1 || mode == 2)
    clc;
    mode = input('Type (1) for single player mode vs. AI, and (2) for two player mode.\n');
end

ask = input('Are you sure you want to play this mode? Press (1)Yes or (2)No\n');

while ~( ask == 1 || ask == 2 )
	ask = input('Please type (1) Yes, (2) No\n');
    clc;
end

while ask == 2
	mode = 0;
    clc;
	while ~(mode == 1 || mode == 2)
        mode = input('Type (1) for single player mode vs. AI, and (2) for two player mode.\n');
        ask = input('Are you sure you want to play this mode? Press (1)Yes or (2)No\n');
        clc;
    end
end

clc;
%% Select difficulty if 1 player mode
if mode == 1 && ask == 1
    ask2 = 0;
    while ask2 ~= 1
        difficulty = 0;
        while difficulty ~= 1 && difficulty ~= 2
        	difficulty = input('Please select your difficulty: (1)Easy, (2)Hard');
        end
        ask2 = input('Are you sure you want to play this mode? (1) Yes (2) No');
        while ask2 ~= 1 && ask2 ~= 2
            ask2 = input('Please select a valid option, (1) Yes (2) No');
        end
    end
end

%% Whatever mode, just need to allow first player to place his stuff
%% If single mode, set p2 to the AI, if 2 player mode, allow p2 to be second player
if (mode == 2 || mode == 1) && ask == 1
    username1 = input(['What''s your name commander? You''re up first.\n\n' ...
    '                         ==^==\n' ...
    '                    _____/|#|//___:\n' ...
    '    ________|______/__0__/____0_0_|____/______\n' ...
    '   (     0      0   ,   0   ,   ````   0       )\n' ...
    '~~~~~~~`~~~~`~~`~~~`~~`~~`~~`~~`~~~`~~~~`~~`~`~~~~~~\n\n'],'s');

    p1turn = 1;
    %%% *** Enter 2 player mode: Player 1's turn *** %%%
        
        fprintf('Let''s see what you got, %s!\n\nStrategically place your ships so your opponent won''t know what hit him!!\n', username1);
        fprintf('%s''s Fortifications:\n', username1);
        
            % Create player primary board
            p1b = ' ';
            
            letterlist = 'ABCDEFGHIJ';
            numlist = '123456789';
            
            for x = 1:9
               p1b(1,(3*x+1)) = numlist(x);
            end
            p1b(1,31:32) = '10';
            
            for k = 2:11
                p1b(k,1) = letterlist(k-1);
            end
            
            for row = 2:11
                for col = 3:3:30
                    p1b(row,col+1) = '~';
                end
            end
            
            p1b(12,:) = ' ';
            p1b(:,33:36) = ' ';
            
            disp(p1b);
            
    while p1turn == 1
        
        % Ask what ship %s would like to place. Loop until that's
        % determined
        
        ships = zeros(1,5);

        
        while ~(ships(1,1) == 1 && ships(1,2) == 2 && ships(1,3) == 3 && ships(1,4) == 4 && ships(1,5) == 5)

            
            asksure = 0;
            
            while asksure ~= 1
                asksure = 0;
                clc;
                fprintf('%s''s Fortifications\n', username1);
                disp(p1b);
                
                whatship = input('\nWhich ship would you like to position now, commander? Type:\n1 for (#) Carrier ~~ length = 5, 2 for (@) Battleship ~~ length = 4\n3 for (%) Destroyer ~~ length = 3, 4 for (&) Submarine ~~ length = 3, and 5 for ($) Patrol Boat ~~ length = 2');
                while ~(whatship == 1 || whatship == 2 || whatship == 3 || whatship == 4 || whatship == 5)
                    whatship = input('Please select a valid option, "commander"! Type one of the options given.');
                end
                asksure = input('Are you sure you want to select that ship? Type (1) Yes, (2) No');
                while asksure ~= 1 && asksure ~= 2
                    asksure = input('Please enter a valid option! Are you sure you want to select that ship? Type (1) yes, (2) No');
                end
            end
            
            % Convert lettered coordinates to workable numbers
            % Also, allow %s to start selecting ships and placing.
            % Carrier
            coord2tonum = 0;
                if whatship == 1 && whatship ~= ships(1,1)
                    prevplace = ' ';
                    ships(1,1) = 1;
                    
                    vertical = 0;
                    horizontal = 0;
                    
                    placed = 1;
                    
                    coord1 = 0;
                    operrow = 0;
                    
                    coord2 = ' ';
                    opercol= 0;
                    
                    confirm = 0;
                    wannaclear = 0;
                    
                    for shippart = 1:5
                        % Select and confrm coordinates
                        confirm = 0;
                        clc;
  
                        if wannaclear == 2
                            confirm = 1;
                        elseif wannaclear == 1
                            wannaclear = 0;
                        end
                        
        
                        while ~(confirm == 1) 
                            fprintf('%s''s Fortifications\n', username1);
                            disp(p1b);
                            
                            valid = 0;                                          
                            while valid == 0
                                coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                for p = 1:10
                                    if coord1 == p
                                        valid = 1;
                                    else
                                    end
                                end
                            end
                            
                            valid2 = 0;
                            while valid2 == 0
                                coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                for p = 1:10
                                    if isequal(coord2,letterlist(p))
                                        valid2 = 1;
                                    else
                                    end
                                end
                            end
                            
                            if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                            else
                                for m = 1:9
                                    if isequal(coord2, letterlist(m))
                                        coord2tonum = m;
                                    else
                                    end
                                end
                            end
                           % Check if on water. If not, allow player to reselect coordinates AND verify again                           
                            onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            while onwater == 0
                                clc;
                                fprintf('%s''s Fortifications\n', username1);
                                disp(p1b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            end
                            operrow = coord2tonum + 1;
                            opercol = 1 + 3*coord1;
                            

                            
                            % Make sure ships are placed horizontally or
                            % vertically. Also, make sure it's placed on
                            % water again
                            if placed == 1 && isequal(prevplace, ' ')
                                p1b((operrow), (opercol)) = '#';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif placed == 2
                                if (isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace)) 
                                    vertical = 1;
                                    horizontal = 0;
                                    p1b((operrow), (opercol)) = '#';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif (isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))
                                    horizontal = 1;
                                    vertical = 0;
                                    p1b((operrow), (opercol)) = '#';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                end
                            elseif vertical == 1 && placed > 2 && ((isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '#';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif horizontal == 1 && placed > 2 && ((isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '#';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            else
                                clc;
                                confirm = 0;
                                fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                            end
                            
                            if confirm == 2
                                clc;
                                p1b((operrow), (opercol)) = '~';
                                
                            elseif confirm == 1 && valid == 1 && valid2 == 1
                                placed = placed + 1;
                                prevplace = p1b((operrow), (opercol));
                            end
                            
                            
                            if confirm == 1
                                while (wannaclear ~= 1) && (wannaclear ~= 2)
                                    clc;
                                    fprintf('%s''s Fortifications\n',username1);
                                    disp(p1b);
                                    wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                    clc;
                                end
                            end
                            
                        end
                        
                        if wannaclear == 2
                            p1b = clearboard(p1b,'#');
                            ships(1,1) = 0;
                        else
                        end
                        
                    end
                    clc;
                    fprintf('%s''s Fortifications', username1);
                    disp(p1b);
                

                % Battleship
                elseif whatship == 2 && whatship ~= ships(1,2)
                    prevplace = ' ';
                    ships(1,2) = 2;
                    
                    vertical = 0;
                    horizontal = 0;
                    
                    placed = 1;
                    
                    coord1 = 0;
                    operrow = 0;
                    
                    coord2 = ' ';
                    opercol= 0;
                    
                    confirm = 0;
                    wannaclear = 0;
                    
                    for shippart = 1:4
                        % Select and confrm coordinates
                        confirm = 0;
                        clc;
                        
                        if wannaclear == 2
                            confirm = 1;
                        elseif wannaclear == 1
                            wannaclear = 0;
                        end
                        
                        while ~(confirm == 1)
                           
                            fprintf('%s''s Fortifications\n', username1);
                            disp(p1b);
                            
                            valid = 0;                                          
                            while valid == 0
                                coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                for p = 1:10
                                    if coord1 == p
                                        valid = 1;
                                    else
                                    end
                                end
                            end
                            
                            valid2 = 0;
                            while valid2 == 0
                                coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                for p = 1:10
                                    if isequal(coord2,letterlist(p))
                                        valid2 = 1;
                                    else
                                    end
                                end
                            end
                            if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                            else
                                for m = 1:9
                                    if isequal(coord2, letterlist(m))
                                        coord2tonum = m;
                                    else
                                    end
                                end
                            end
                            
                            
                            onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            while onwater == 0
                                clc;
                                fprintf('%s''s Fortifications\n', username1);
                                disp(p1b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            end
                            operrow = coord2tonum + 1;
                            opercol = 1 + 3*coord1;
                            
                            
                            % Make sure ships are placed horizontally or
                            % vertically. Also, make sure it's placed on
                            % water again
                            if placed == 1 && isequal(prevplace, ' ')
                                p1b((operrow), (opercol)) = '@';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif placed == 2
                                if (isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace)) 
                                    vertical = 1;
                                    horizontal = 0;
                                    p1b((operrow), (opercol)) = '@';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif (isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))
                                    horizontal = 1;
                                    vertical = 0;
                                    p1b((operrow), (opercol)) = '@';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                end
                            elseif vertical == 1 && placed > 2 && ((isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '@';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif horizontal == 1 && placed > 2 && ((isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '@';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            else
                                clc;
                                confirm = 0;
                                fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                            end
                            
                            
                            
                            if confirm == 2
                                clc;
                                p1b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                
                            elseif confirm == 1 && valid == 1 && valid2 == 1
                                placed = placed + 1;
                                prevplace = p1b((coord2tonum + 1), (1 + 3*coord1));
                            end
                            
                           if confirm == 1
                                while (wannaclear ~= 1) && (wannaclear ~= 2)
                                    clc;
                                    fprintf('%s''s Fortifications\n',username1);
                                    disp(p1b);
                                    wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                    clc;
                                end
                           end
                            
                        end
                        
                        if wannaclear == 2
                            p1b = clearboard(p1b,'@');
                            ships(1,2) = 0;
                        else
                        end
                        
                    end
                    clc;
                    fprintf('%s''s Fortifications\n', username1);
                    disp(p1b);
                    
                % Destroyer
                elseif whatship == 3 && whatship ~= ships(1,3)
                    prevplace = ' ';
                    ships(1,3) = 3;
                    
                    vertical = 0;
                    horizontal = 0;
                    
                    placed = 1;
                    
                    coord1 = 0;
                    operrow = 0;
                    
                    coord2 = ' ';
                    opercol= 0;
                    
                    confirm = 0;
                    wannaclear = 0;
                    for shippart = 1:3
                        % Select and confrm coordinates
                        confirm = 0;
                        clc;
                        
                        if wannaclear == 2
                            confirm = 1;
                            
                        elseif wannaclear == 1
                            wannaclear = 0;
                        end
                        
                        while ~(confirm == 1)
                           
                            fprintf('%s''s Fortifications\n', username1);
                            disp(p1b);
                            valid = 0;                                          
                            while valid == 0
                                coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                for p = 1:10
                                    if coord1 == p
                                        valid = 1;
                                    else
                                    end
                                end
                            end
                            
                            valid2 = 0;
                            while valid2 == 0
                                coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                for p = 1:10
                                    if isequal(coord2,letterlist(p))
                                        valid2 = 1;
                                    else
                                    end
                                end
                            end
                            if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                            else
                                for m = 1:9
                                    if isequal(coord2, letterlist(m))
                                        coord2tonum = m;
                                    else
                                    end
                                end
                            end
                            
                            
                            onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            while onwater == 0
                                clc;
                                fprintf('%s''s Fortifications\n', username1);
                                disp(p1b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            end
                            operrow = coord2tonum + 1;
                            opercol = 1 + 3*coord1;
                            
                            % Make sure ships are placed horizontally or
                            % vertically. Also, make sure it's placed on
                            % water again
                            if placed == 1 && isequal(prevplace, ' ')
                                p1b((operrow), (opercol)) = '%';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif placed == 2
                                if (isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace)) 
                                    vertical = 1;
                                    horizontal = 0;
                                    p1b((operrow), (opercol)) = '%';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif (isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))
                                    horizontal = 1;
                                    vertical = 0;
                                    p1b((operrow), (opercol)) = '%';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                end
                            elseif vertical == 1 && placed > 2 && ((isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '%';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif horizontal == 1 && placed > 2 && ((isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '%';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            else
                                clc;
                                confirm = 0;
                                fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                            end
                            
                            
                            
                            if confirm == 2
                                clc;
                                p1b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                
                            elseif confirm == 1 && valid == 1 && valid2 == 1
                                placed = placed + 1;
                                prevplace = p1b((coord2tonum + 1), (1 + 3*coord1));
                            end
                            
                           if confirm == 1
                                while (wannaclear ~= 1) && (wannaclear ~= 2)
                                    clc;
                                    fprintf('%s''s Fortifications\n',username1);
                                    disp(p1b);
                                    wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                    clc;
                                end
                           end
                            
                        end
                        
                        if wannaclear == 2
                            p1b = clearboard(p1b,'%');
                            ships(1,3) = 0;
                        else
                        end
                        
                    end
                    clc;
                    fprintf('%s''s Fortifications\n', username1);
                    disp(p1b);
                    
                % Submarine    
                elseif whatship == 4 && whatship ~= ships(1,4)
                    prevplace = ' ';
                    ships(1,4) = 4;
                    
                    vertical = 0;
                    horizontal = 0;
                    
                    placed = 1;
                    
                    coord1 = 0;
                    operrow = 0;
                    
                    coord2 = ' ';
                    opercol= 0;
                    
                    confirm = 0;
                    wannaclear = 0;
                    for shippart = 1:3
                        % Select and confrm coordinates
                        confirm = 0;
                        clc;
                        
                        if wannaclear == 2
                            confirm = 1;
                            
                        elseif wannaclear == 1
                            wannaclear = 0;
                        end
                        
                        while ~(confirm == 1)
                           
                            fprintf('%s''s Fortifications\n', username1);
                            disp(p1b);
                            valid = 0;                                          
                            while valid == 0
                                coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                for p = 1:10
                                    if coord1 == p
                                        valid = 1;
                                    else
                                    end
                                end
                            end
                            
                            valid2 = 0;
                            while valid2 == 0
                                coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                for p = 1:10
                                    if isequal(coord2,letterlist(p))
                                        valid2 = 1;
                                    else
                                    end
                                end
                            end
                            
                            if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                            else
                                for m = 1:9
                                    if isequal(coord2, letterlist(m))
                                        coord2tonum = m;
                                    else
                                    end
                                end
                            end
                            
                            
                            onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            while onwater == 0
                                clc;
                                fprintf('%s''s Fortifications\n', username1);
                                disp(p1b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            end
                            operrow = coord2tonum + 1;
                            opercol = 1 + 3*coord1;
                            
                            
                            % Make sure ships are placed horizontally or
                            % vertically. Also, make sure it's placed on
                            % water again
                            if placed == 1 && isequal(prevplace, ' ')
                                p1b((operrow), (opercol)) = '&';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif placed == 2
                                if (isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace)) 
                                    vertical = 1;
                                    horizontal = 0;
                                    p1b((operrow), (opercol)) = '&';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif (isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))
                                    horizontal = 1;
                                    vertical = 0;
                                    p1b((operrow), (opercol)) = '&';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                end
                            elseif vertical == 1 && placed > 2 && ((isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '&';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif horizontal == 1 && placed > 2 && ((isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '&';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            else
                                clc;
                                confirm = 0;
                                fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                            end
                            
                            
                            
                            if confirm == 2
                                clc;
                                p1b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                
                            elseif confirm == 1 && valid == 1 && valid2 == 1
                                placed = placed + 1;
                                prevplace = p1b((coord2tonum + 1), (1 + 3*coord1));
                            end
                            
                          if confirm == 1
                                while (wannaclear ~= 1) && (wannaclear ~= 2)
                                    clc;
                                    fprintf('%s''s Fortifications\n',username1);
                                    disp(p1b);
                                    wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                    clc;
                                end
                          end
                            
                        end
                        
                        if wannaclear == 2
                            p1b = clearboard(p1b,'&');
                            ships(1,4) = 0;
                        else
                        end
                        
                        
                    end
                    clc;
                    fprintf('%s''s Fortifications\n', username1);
                    disp(p1b);
                    
                    
                % Patrol Boat
                elseif whatship == 5 && whatship ~= ships(1,5)
                    prevplace = ' ';
                    ships(1,5) = 5;
                    
                    vertical = 0;
                    horizontal = 0;
                    
                    placed = 1;
                    
                    coord1 = 0;
                    operrow = 0;
                    
                    coord2 = ' ';
                    opercol= 0;
                    
                    confirm = 0;
                    wannaclear = 0;
                    
                    for shippart = 1:2
                        % Select and confrm coordinates
                        confirm = 0;
                        clc;
                        
                        if wannaclear == 2
                            confirm = 1;
                            
                        elseif wannaclear == 1
                            wannaclear = 0;
                        end
                        
                        while ~(confirm == 1)
                            
                            fprintf('%s''s Fortifications\n', username1);
                            disp(p1b);
                            valid = 0;                                          
                            while valid == 0
                                coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                for p = 1:10
                                    if coord1 == p
                                        valid = 1;
                                    else
                                    end
                                end
                            end
                            
                            valid2 = 0;
                            while valid2 == 0
                                coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                for p = 1:10
                                    if isequal(coord2,letterlist(p))
                                        valid2 = 1;
                                    else
                                    end
                                end
                            end
                            if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                            else
                                for m = 1:9
                                    if isequal(coord2, letterlist(m))
                                        coord2tonum = m;
                                    else
                                    end
                                end
                            end
                            
                            
                            onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            while onwater == 0
                                clc;
                                fprintf('%s''s Fortifications\n', username1);
                                disp(p1b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                onwater = verify(p1b((coord2tonum + 1), (1 + 3*coord1)));
                            end
                            operrow = coord2tonum + 1;
                            opercol = 1 + 3*coord1;
                            
                            % Make sure ships are placed horizontally or
                            % vertically. Also, make sure it's placed on
                            % water again
                            if placed == 1 && isequal(prevplace, ' ')
                                p1b((operrow), (opercol)) = '$';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif placed == 2
                                if (isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace)) 
                                    vertical = 1;
                                    horizontal = 0;
                                    p1b((operrow), (opercol)) = '$';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif (isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))
                                    horizontal = 1;
                                    vertical = 0;
                                    p1b((operrow), (opercol)) = '$';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                end
                            elseif vertical == 1 && placed > 2 && ((isequal(p1b((operrow - 1), (opercol)),prevplace)) || (isequal(p1b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '$';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            elseif horizontal == 1 && placed > 2 && ((isequal(p1b((operrow), (opercol + 3)),prevplace)) || (isequal(p1b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                p1b((operrow), (opercol)) = '$';
                                confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                            else
                                clc;
                                confirm = 0;
                                fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                            end
                            
                            
                            
                            if confirm == 2
                                clc;
                                p1b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                
                            elseif confirm == 1 && valid == 1 && valid2 == 1
                                placed = placed + 1;
                                prevplace = p1b((coord2tonum + 1), (1 + 3*coord1));
                            end
                            if confirm == 1
                                while (wannaclear ~= 1) && (wannaclear ~= 2)
                                    clc;
                                    fprintf('%s''s Fortifications\n',username1);
                                    disp(p1b);
                                    wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                    clc;
                                end
                            end
                        end
                        
                        if wannaclear == 2
                            p1b = clearboard(p1b,'$');
                            ships(1,5) = 0;
                        else
                        end
                        
                    end
                    clc;
                    fprintf('%s''s Fortifications\n', username1);
                    disp(p1b);
            end
        end
        clc;
        p1turn = 0;
        fprintf('%s''s Foritifications\n', username1);
        disp(p1b);
        finalboard = 0;
        while finalboard ~= 1
            finalboard = input('This is your final board, you can''t make any more changes!!! Type (1) to continue');
        end
    end
    %%% Player 2 starts now %%%
    clc;
    if mode == 2
        p2turn = 1;
        username2 = input(['Player 2, you''re up next. What''s your name?\n\n' ...
            '                         ==^==\n' ...
        '                    _____/|#|//___:\n' ...
        '    ________|______/__0__/____0_0_|____/______\n' ...
        '   (     0      0   ,   0   ,   ````   0       )\n' ...
        '~~~~~~~`~~~~`~~`~~~`~~`~~`~~`~~`~~~`~~~~`~~`~`~~~~~~\n\n'],'s');
        
        
            fprintf('%s''s Fortifications:\n',username2)
            
                % Create player 2 primary board
                p2b = ' ';
                
                letterlist = 'ABCDEFGHIJ';
                numlist = '123456789';
                
                for x = 1:9
                   p2b(1,(3*x+1)) = numlist(x);
                end
                p2b(1,31:32) = '10';
                
                for k = 2:11
                    p2b(k,1) = letterlist(k-1);
                end
                
                for row = 2:11
                    for col = 3:3:30
                        p2b(row,col+1) = '~';
                    end
                end
                
                p2b(12,:) = ' ';
                p2b(:,33:36) = ' ';
                
                disp(p2b);
                
        while p2turn == 1
            
            % Ask what ship %s would like to place. Loop until that's
            % determined
            
            ships = zeros(1,5);
            
            while ~(ships(1,1) == 1 && ships(1,2) == 2 && ships(1,3) == 3 && ships(1,4) == 4 && ships(1,5) == 5)
                asksure = 0;
                
                while asksure ~= 1
                    asksure = 0;
                    clc;
                    fprintf('%s''s Fortifications\n', username2);
                    disp(p2b);
                    
                    whatship = input('\nWhich ship would you like to position now, commander? Type:\n1 for (#) Carrier ~~ length = 5, 2 for (@) Battleship ~~ length = 4\n3 for (%) Destroyer ~~ length = 3, 4 for (&) Submarine ~~ length = 3, and 5 for ($) Patrol Boat ~~ length = 2');
                    while ~(whatship == 1 || whatship == 2 || whatship == 3 || whatship == 4 || whatship == 5)
                        whatship = input('Please select a valid option, "commander"! Type one of the options given.');
                    end
                    asksure = input('Are you sure you want to select that ship? Type (1) Yes, (2) No');
                    while asksure ~= 1 && asksure ~= 2
                        asksure = input('Please enter a valid option! Are you sure you want to select that ship? Type (1) yes, (2) No');
                    end
                end
                
                % Convert lettered coordinates to workable numbers
                % Also, allow %s to start selecting ships and placing.
                % Carrier
                coord2tonum = 0;
                    if whatship == 1 && whatship ~= ships(1,1)
                        prevplace = ' ';
                        ships(1,1) = 1;
                        
                        vertical = 0;
                        horizontal = 0;
                        
                        placed = 1;
                        
                        coord1 = 0;
                        operrow = 0;
                        
                        coord2 = ' ';
                        opercol= 0;
                        
                        confirm = 0;
                        wannaclear = 0;
                        
                        for shippart = 1:5
                            % Select and confrm coordinates
                            confirm = 0;
                            clc;
      
                            if wannaclear == 2
                                confirm = 1;
                                
                            elseif wannaclear == 1
                                wannaclear = 0;
                            end
                            
            
                            while ~(confirm == 1) 
                                fprintf('%s''s Fortifications\n', username2);
                                disp(p2b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                               % Check if on water. If not, allow player to reselect coordinates AND verify again                           
                                onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                while onwater == 0
                                    clc;
                                    fprintf('%s''s Fortifications\n', username2);
                                    disp(p2b);
                                    
                                    valid = 0;                                          
                                    while valid == 0
                                        coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                        for p = 1:10
                                            if coord1 == p
                                                valid = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    valid2 = 0;
                                    while valid2 == 0
                                        coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                        for p = 1:10
                                            if isequal(coord2,letterlist(p))
                                                valid2 = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                    else
                                        for m = 1:9
                                            if isequal(coord2, letterlist(m))
                                                coord2tonum = m;
                                            else
                                            end
                                        end
                                    end
                                    onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                end
                                operrow = coord2tonum + 1;
                                opercol = 1 + 3*coord1;
                                
    
                                
                                % Make sure ships are placed horizontally or
                                % vertically. Also, make sure it's placed on
                                % water again
                                if placed == 1 && isequal(prevplace, ' ')
                                    p2b((operrow), (opercol)) = '#';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif placed == 2
                                    if (isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace)) 
                                        vertical = 1;
                                        horizontal = 0;
                                        p2b((operrow), (opercol)) = '#';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    elseif (isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))
                                        horizontal = 1;
                                        vertical = 0;
                                        p2b((operrow), (opercol)) = '#';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    end
                                elseif vertical == 1 && placed > 2 && ((isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '#';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif horizontal == 1 && placed > 2 && ((isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '#';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                else
                                    clc;
                                    confirm = 0;
                                    fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                                end
                                
                                if confirm == 2
                                    clc;
                                    p2b((operrow), (opercol)) = '~';
                                    
                                elseif confirm == 1 && valid == 1 && valid2 == 1
                                    placed = placed + 1;
                                    prevplace = p2b((operrow), (opercol));
                                end
                                if confirm == 1  
                                    while (wannaclear ~= 1) && (wannaclear ~= 2)
                                        clc;
                                        fprintf('%s''s Fortifications\n',username2);
                                        disp(p2b);
                                        wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                        clc;
                                    end
                                end
                                
                            end
                            
                            if wannaclear == 2
                                p2b = clearboard(p2b,'#');
                                ships(1,1) = 0;
                            else
                            end
                            
                        end
                        clc;
                        fprintf('%s''s Fortifications', username2);
                        disp(p2b);
                    
    
                    % Battleship
                    elseif whatship == 2 && whatship ~= ships(1,2)
                        prevplace = ' ';
                        ships(1,2) = 2;
                        
                        vertical = 0;
                        horizontal = 0;
                        
                        placed = 1;
                        
                        coord1 = 0;
                        operrow = 0;
                        
                        coord2 = ' ';
                        opercol= 0;
                        
                        confirm = 0;
                        wannaclear = 0;
                        
                        for shippart = 1:4
                            % Select and confrm coordinates
                            confirm = 0;
                            clc;
                            
                            if wannaclear == 2
                                confirm = 1;
                                
                            elseif wannaclear == 1
                                wannaclear = 0;
                            end
                            
                            while ~(confirm == 1)
                               
                                fprintf('%s''s Fortifications\n', username2);
                                disp(p2b);
                                
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                
                                
                                onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                while onwater == 0
                                    clc;
                                    fprintf('%s''s Fortifications\n', username2);
                                    disp(p2b);
                                    
                                    valid = 0;                                          
                                    while valid == 0
                                        coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                        for p = 1:10
                                            if coord1 == p
                                                valid = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    valid2 = 0;
                                    while valid2 == 0
                                        coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                        for p = 1:10
                                            if isequal(coord2,letterlist(p))
                                                valid2 = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                    else
                                        for m = 1:9
                                            if isequal(coord2, letterlist(m))
                                                coord2tonum = m;
                                            else
                                            end
                                        end
                                    end
                                    onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                end
                                operrow = coord2tonum + 1;
                                opercol = 1 + 3*coord1;
                                
                                
                                % Make sure ships are placed horizontally or
                                % vertically. Also, make sure it's placed on
                                % water again
                                if placed == 1 && isequal(prevplace, ' ')
                                    p2b((operrow), (opercol)) = '@';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif placed == 2
                                    if (isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace)) 
                                        vertical = 1;
                                        horizontal = 0;
                                        p2b((operrow), (opercol)) = '@';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    elseif (isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))
                                        horizontal = 1;
                                        vertical = 0;
                                        p2b((operrow), (opercol)) = '@';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    end
                                elseif vertical == 1 && placed > 2 && ((isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '@';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif horizontal == 1 && placed > 2 && ((isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '@';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                else
                                    clc;
                                    confirm = 0;
                                    fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                                end
                                
                                
                                
                                if confirm == 2
                                    clc;
                                    p2b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                    
                                elseif confirm == 1 && valid == 1 && valid2 == 1
                                    placed = placed + 1;
                                    prevplace = p2b((coord2tonum + 1), (1 + 3*coord1));
                                end
                                if confirm == 1
                                    while (wannaclear ~= 1) && (wannaclear ~= 2)
                                        clc;
                                        fprintf('%s''s Fortifications\n',username2);
                                        disp(p2b);
                                        wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                        clc;
                                    end
                                end
                                
                            end
                            
                            if wannaclear == 2
                                p2b = clearboard(p2b,'@');
                                ships(1,2) = 0;
                            else
                            end
                            
                        end
                        clc;
                        fprintf('%s''s Fortifications\n', username2);
                        disp(p2b);
                        
                    % Destroyer
                    elseif whatship == 3 && whatship ~= ships(1,3)
                        prevplace = ' ';
                        ships(1,3) = 3;
                        
                        vertical = 0;
                        horizontal = 0;
                        
                        placed = 1;
                        
                        coord1 = 0;
                        operrow = 0;
                        
                        coord2 = ' ';
                        opercol= 0;
                        
                        confirm = 0;
                        wannaclear = 0;
                        for shippart = 1:3
                            % Select and confrm coordinates
                            confirm = 0;
                            clc;
                            
                            if wannaclear == 2
                                confirm = 1;
                                
                            elseif wannaclear == 1
                                wannaclear = 0;
                            end
                            
                            while ~(confirm == 1)
                               
                                fprintf('%s''s Fortifications\n', username2);
                                disp(p2b);
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                
                                
                                onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                while onwater == 0
                                    clc;
                                    fprintf('%s''s Fortifications\n', username2);
                                    disp(p2b);
                                    
                                    valid = 0;                                          
                                    while valid == 0
                                        coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                        for p = 1:10
                                            if coord1 == p
                                                valid = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    valid2 = 0;
                                    while valid2 == 0
                                        coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                        for p = 1:10
                                            if isequal(coord2,letterlist(p))
                                                valid2 = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                    else
                                        for m = 1:9
                                            if isequal(coord2, letterlist(m))
                                                coord2tonum = m;
                                            else
                                            end
                                        end
                                    end
                                    onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                end
                                operrow = coord2tonum + 1;
                                opercol = 1 + 3*coord1;
                                
                                % Make sure ships are placed horizontally or
                                % vertically. Also, make sure it's placed on
                                % water again
                                if placed == 1 && isequal(prevplace, ' ')
                                    p2b((operrow), (opercol)) = '%';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif placed == 2
                                    if (isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace)) 
                                        vertical = 1;
                                        horizontal = 0;
                                        p2b((operrow), (opercol)) = '%';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    elseif (isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))
                                        horizontal = 1;
                                        vertical = 0;
                                        p2b((operrow), (opercol)) = '%';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    end
                                elseif vertical == 1 && placed > 2 && ((isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '%';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif horizontal == 1 && placed > 2 && ((isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '%';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                else
                                    clc;
                                    confirm = 0;
                                    fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                                end
                                
                                
                                
                                if confirm == 2
                                    clc;
                                    p2b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                    
                                elseif confirm == 1 && valid == 1 && valid2 == 1
                                    placed = placed + 1;
                                    prevplace = p2b((coord2tonum + 1), (1 + 3*coord1));
                                end
                                
                                if confirm == 1
                                    while (wannaclear ~= 1) && (wannaclear ~= 2)
                                        clc;
                                        fprintf('%s''s Fortifications\n',username2);
                                        disp(p2b);
                                        wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                        clc;
                                    end
                                end
                                
                            end
                            
                            if wannaclear == 2
                                p2b = clearboard(p2b,'%');
                                ships(1,3) = 0;
                            else
                            end
                            
                        end
                        clc;
                        fprintf('%s''s Fortifications\n', username2);
                        disp(p2b);
                        
                    % Submarine    
                    elseif whatship == 4 && whatship ~= ships(1,4)
                        prevplace = ' ';
                        ships(1,4) = 4;
                        
                        vertical = 0;
                        horizontal = 0;
                        
                        placed = 1;
                        
                        coord1 = 0;
                        operrow = 0;
                        
                        coord2 = ' ';
                        opercol= 0;
                        
                        confirm = 0;
                        wannaclear = 0;
                        for shippart = 1:3
                            % Select and confrm coordinates
                            confirm = 0;
                            clc;
                            
                            if wannaclear == 2
                                confirm = 1;
                                
                            elseif wannaclear == 1
                                wannaclear = 0;
                            end
                            
                            while ~(confirm == 1)
                               
                                fprintf('%s''s Fortifications\n', username2);
                                disp(p2b);
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                
                                if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                
                                
                                onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                while onwater == 0
                                    clc;
                                    fprintf('%s''s Fortifications\n', username2);
                                    disp(p2b);
                                    
                                    valid = 0;                                          
                                    while valid == 0
                                        coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                        for p = 1:10
                                            if coord1 == p
                                                valid = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    valid2 = 0;
                                    while valid2 == 0
                                        coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                        for p = 1:10
                                            if isequal(coord2,letterlist(p))
                                                valid2 = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                    else
                                        for m = 1:9
                                            if isequal(coord2, letterlist(m))
                                                coord2tonum = m;
                                            else
                                            end
                                        end
                                    end
                                    onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                end
                                operrow = coord2tonum + 1;
                                opercol = 1 + 3*coord1;
                                
                                
                                % Make sure ships are placed horizontally or
                                % vertically. Also, make sure it's placed on
                                % water again
                                if placed == 1 && isequal(prevplace, ' ')
                                    p2b((operrow), (opercol)) = '&';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif placed == 2
                                    if (isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace)) 
                                        vertical = 1;
                                        horizontal = 0;
                                        p2b((operrow), (opercol)) = '&';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    elseif (isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))
                                        horizontal = 1;
                                        vertical = 0;
                                        p2b((operrow), (opercol)) = '&';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    end
                                elseif vertical == 1 && placed > 2 && ((isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '&';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif horizontal == 1 && placed > 2 && ((isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '&';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                else
                                    clc;
                                    confirm = 0;
                                    fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                                end
                                
                                
                                
                                if confirm == 2
                                    clc;
                                    p2b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                    
                                elseif confirm == 1 && valid == 1 && valid2 == 1
                                    placed = placed + 1;
                                    prevplace = p2b((coord2tonum + 1), (1 + 3*coord1));
                                end
                                
                                if confirm == 1
                                    while (wannaclear ~= 1) && (wannaclear ~= 2)
                                        clc;
                                        fprintf('%s''s Fortifications\n',username2);
                                        disp(p2b);
                                        wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                        clc;
                                    end
                                end
                            end
                            
                            if wannaclear == 2
                                p2b = clearboard(p2b,'&');
                                ships(1,4) = 0;
                            else
                            end
                            
                            
                        end
                        clc;
                        fprintf('%s''s Fortifications\n', username2);
                        disp(p2b);
                        
                        
                    % Patrol Boat
                    elseif whatship == 5 && whatship ~= ships(1,5)
                        prevplace = ' ';
                        ships(1,5) = 5;
                        
                        vertical = 0;
                        horizontal = 0;
                        
                        placed = 1;
                        
                        coord1 = 0;
                        operrow = 0;
                        
                        coord2 = ' ';
                        opercol= 0;
                        
                        confirm = 0;
                        wannaclear = 0;
                        
                        for shippart = 1:2
                            % Select and confrm coordinates
                            confirm = 0;
                            clc;
                            
                            if wannaclear == 2
                                confirm = 1;
                               
                            elseif wannaclear == 1
                                wannaclear = 0;
                            end
                            
                            while ~(confirm == 1)
                                
                                fprintf('%s''s Fortifications\n', username2);
                                disp(p2b);
                                valid = 0;                                          
                                while valid == 0
                                    coord1 = input('Please enter the NUMBER coordinate of your ship between 1 and 10. Remember your ship can only be horizontal and vertical.');
                                    for p = 1:10
                                        if coord1 == p
                                            valid = 1;
                                        else
                                        end
                                    end
                                end
                                
                                valid2 = 0;
                                while valid2 == 0
                                    coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                    for p = 1:10
                                        if isequal(coord2,letterlist(p))
                                            valid2 = 1;
                                        else
                                        end
                                    end
                                end
                                if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                else
                                    for m = 1:9
                                        if isequal(coord2, letterlist(m))
                                            coord2tonum = m;
                                        else
                                        end
                                    end
                                end
                                
                                
                                onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                while onwater == 0
                                    clc;
                                    fprintf('%s''s Fortifications\n', username2);
                                    disp(p2b);
                                    
                                    valid = 0;                                          
                                    while valid == 0
                                        coord1 = input('THAT SPOT IS TAKEN UP ALREADY. Type the NUMBER (1 to 10) coordinate of your ship.');
                                        for p = 1:10
                                            if coord1 == p
                                                valid = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    valid2 = 0;
                                    while valid2 == 0
                                        coord2 = input('Now, please enter the LETTER coordinate of your ship (A to J), in CAPS.','s');
                                        for p = 1:10
                                            if isequal(coord2,letterlist(p))
                                                valid2 = 1;
                                            else
                                            end
                                        end
                                    end
                                    
                                    if isequal(coord2, letterlist(10))
                                    coord2tonum = 10;
                                    else
                                        for m = 1:9
                                            if isequal(coord2, letterlist(m))
                                                coord2tonum = m;
                                            else
                                            end
                                        end
                                    end
                                    onwater = verify(p2b((coord2tonum + 1), (1 + 3*coord1)));
                                end
                                operrow = coord2tonum + 1;
                                opercol = 1 + 3*coord1;
                                
                                % Make sure ships are placed horizontally or
                                % vertically. Also, make sure it's placed on
                                % water again
                                if placed == 1 && isequal(prevplace, ' ')
                                    p2b((operrow), (opercol)) = '$';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif placed == 2
                                    if (isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace)) 
                                        vertical = 1;
                                        horizontal = 0;
                                        p2b((operrow), (opercol)) = '$';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    elseif (isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))
                                        horizontal = 1;
                                        vertical = 0;
                                        p2b((operrow), (opercol)) = '$';
                                        confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                    end
                                elseif vertical == 1 && placed > 2 && ((isequal(p2b((operrow - 1), (opercol)),prevplace)) || (isequal(p2b((operrow + 1), (opercol)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '$';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                elseif horizontal == 1 && placed > 2 && ((isequal(p2b((operrow), (opercol + 3)),prevplace)) || (isequal(p2b((operrow), (opercol - 3)),prevplace))) && onwater == 1
                                    p2b((operrow), (opercol)) = '$';
                                    confirm = input('Are you sure of those coordinates commander? (1) Yes, (2) No\n');
                                else
                                    clc;
                                    confirm = 0;
                                    fprintf('THOSE ARE NOT VALID COORDINATES. Your placement must be aligned vertically and horizontally and your ship cannot have a gap in it!!\n\n')
                                end
                                
                                
                                
                                if confirm == 2
                                    clc;
                                    p2b((coord2tonum + 1), (1 + 3*coord1)) = '~';
                                    
                                elseif confirm == 1 && valid == 1 && valid2 == 1
                                    placed = placed + 1;
                                    prevplace = p2b((coord2tonum + 1), (1 + 3*coord1));
                                end
                                
                                if confirm == 1
                                    while (wannaclear ~= 1) && (wannaclear ~= 2)
                                        clc;
                                        fprintf('%s''s Fortifications\n',username2);
                                        disp(p2b);
                                        wannaclear = input('Type (1) to continue placing parts or (2) to reset your ship.');
                                        clc;
                                    end
                                end
                            end
                            
                            if wannaclear == 2
                                p2b = clearboard(p2b,'$');
                                ships(1,5) = 0;
                            else
                            end
                            
                        end
                        clc;
                        fprintf('%s''s Fortifications\n', username2);
                        disp(p2b);
                    end
            end
            p2turn = 0;
            clc;
            fprintf('%s''s Foritifications\n', username2);
            disp(p2b);
            finalboard = 0;
            while finalboard ~= 1
                finalboard = input('This is your final board, you can''t make any more changes!!! Type (1) to continue');
            end
        end
    elseif mode == 1
        % Create player 2 primary board
            p2b = ' ';
            
            letterlist = 'ABCDEFGHIJ';
            numlist = '123456789';
            
            for x = 1:9
               p2b(1,(3*x+1)) = numlist(x);
            end
            p2b(1,31:32) = '10';
            
            for k = 2:11
                p2b(k,1) = letterlist(k-1);
            end
            
            for row = 2:11
                for col = 3:3:30
                    p2b(row,col+1) = '~';
                end
            end
            
            p2b(12,:) = ' ';
            p2b(:,33:36) = ' ';
            
            %% Randomly generate a value 1:15 and select a board from predetermined
            boardselect = floor(1+15*rand);
            if boardselect == 1
                p2b(8,13:3:25) = '#';
                p2b(3:6, 7) = '@';
                p2b(4:7, 22) = '%';
                p2b(3,13:3:19) = '&';
                p2b(10:11, 28) = '$';
            elseif boardselect == 2
                p2b(3,4:3:16) = '#';
                p2b(9,16:3:25) = '@';
                p2b(7:9,7) = '%';
                p2b(6,19:3:25) = '&';
                p2b(3:4,31) = '$';
            elseif boardselect == 3
                p2b(4:8,10) = '#';
                p2b(5,16:3:25) = '@';
                p2b(9,13:3:19) = '%';
                p2b(8:10, 31) = '&';
                p2b(10,7:3:10) = '$';
            elseif boardselect == 4
                p2b(7:11, 28) = '#';
                p2b(5:8, 13) = '@';
                p2b(3,7:3:13) = '%';
                p2b(5, 22:3:28) = '&';
                p2b(10,7:3:10) = '$';
            elseif boardselect == 5
                p2b(7:11, 4) = '#';
                p2b(10, 16:3:25) = '@';
                p2b(3:5, 10) = '%';
                p2b(6:8, 22) = '&';
                p2b(3,22:3:25) = '$';
            elseif boardselect == 6
                p2b(7,16:3:28)='#';
                p2b(8,10:3:19)='@';
                p2b(9:11,31)='%';
                p2b(4:6,7)='&';
                p2b(2:3,22)='$';
            elseif boardselect == 7
                p2b(4,13:3:25)='#';
                p2b(7:10,16)='@';
                p2b(3,7:3:13)='%';
                p2b(7,25:3:31)='&';
                p2b(6:7,7)='$';
            elseif boardselect == 8
                p2b(2:6,22)='#';
                p2b(8,7:3:16)='@';
                p2b(10,19:3:25)='%';
                p2b(3:5,10)='&';
                p2b(8,25:3:28)='$';
            elseif boardselect == 9 
                p2b(7,4:3:16)='#';
                p2b(3:6,31)='@';
                p2b(3:5,7)='%';
                p2b(4,19:3:25)='&';
                p2b(10,10:3:13)='$';
            elseif boardselect == 10
                p2b(6:10,25)='#';
                p2b(3:6,19)='@';
                p2b(6,7:3:13)='%';
                p2b(9,7:3:13)='&';
                p2b(3:4,7)='$';
            elseif boardselect == 11
                p2b(8,16:3:28)='#';
                p2b(6,7:3:16)='@';
                p2b(2:5,22)='%';
                p2b(2:4,16)='&';
                p2b(2,7:3:10)='$';
            elseif boardselect == 12
                p2b(6:10,7)='#';
                p2b(10,19:3:31)='@';
                p2b(6,22:3:28)='%';
                p2b(3:5,13)='&';
                p2b(3:4,28)='$';
            elseif boardselect == 13
                p2b(2:6,22)='#';
                p2b(3,10:3:16)='@';
                p2b(5:7,13)='%';
                p2b(9,13:3:19)='&';
                p2b(2,28:3:31)='$';
            elseif boardselect == 14
                p2b(3:7,7)='#';
                p2b(2:5,28)='@';
                p2b(4:6,13)='%';
                p2b(8,16:3:22)='&';
                p2b(5:6,19)='$';
            elseif boardselect == 15
                p2b(2,19:3:31)='#';
                p2b(7:10,7)='@';
                p2b(5,16:3:22)='%';
                p2b(7:9,22)='&';
                p2b(3:4,10)='$';
            else
            end
    end
end
    
    
    
    %% Create Player 1 secondary boards and Player 2 secondary boards. %%
    % Create player 1 secondary board (p1bs)
            p1bs = ' ';
            
            letterlist = 'ABCDEFGHIJ';
            numlist = '123456789';
            
            for x = 1:9
               p1bs(1,(3*x+1)) = numlist(x);
            end
            p1bs(1,31:32) = '10';
            
            for k = 2:11
                p1bs(k,1) = letterlist(k-1);
            end
            
            for row = 2:11
                for col = 3:3:30
                    p1bs(row,col+1) = '~';
                end
            end
            
            p1bs(12,:) = ' ';
            p1bs(:,33:36) = ' ';
            
    % Create Player 2 secondary board (p2bs)
            p2bs = ' ';
            
            letterlist = 'ABCDEFGHIJ';
            numlist = '123456789';
            
            for x = 1:9
               p2bs(1,(3*x+1)) = numlist(x);
            end
            p2bs(1,31:32) = '10';
            
            for k = 2:11
                p2bs(k,1) = letterlist(k-1);
            end
            
            for row = 2:11
                for col = 3:3:30
                    p2bs(row,col+1) = '~';
                end
            end
            
            p2bs(12,:) = ' ';
            p2bs(:,33:36) = ' ';


    %% Time for Player 1 and Player 2 to play. Play until a winner is decided. %%%%%
    % Win condition: all of one's person's primary board ship parts are destroyed. (17 total)
    
    % no winner yet
    whowon = 0;
    
    % player 1 starts first
    p1turn = 1;
    p2turn = 0;
    
    % counter for number of hits for each player. 17 is the win condition
    p1numhits = 0;
    p2numhits = 0;
    prevcoord1 = 1;
    prevcoord2 = 1;
    vert = 0;
    horiz = 0;
    hittest = 0;
    
   
    while whowon == 0 
        %% Start with player 1 attack moves %%
        if p1turn == 1
            if mode == 1
                username2 = 'Admiral Vladimir';
            else
            end
            confirmatk = 0;
            while ~(confirmatk == 1) 
            clc;
            fprintf('You''re up %s!\nStrategically decide your next attack...\n"X" signifies a hit, "O" signifies a miss\n', username1);
            fprintf('%s''s Territory\n', username2);
            disp(p2bs);
            
            valid = 0;                                          
            while valid == 0
                coord1 = input('Enter the number coordinate of your point of attack (1 - 10), Admiral!');
                for p = 1:10
                    if coord1 == p
                        valid = 1;
                    else
                    end
                end
            end
            
            valid2 = 0;
            while valid2 == 0
                coord2 = input('Now, Enter the LETTER coordinate of your point of attack (A to J), in CAPS.','s');
                for p = 1:10
                    if isequal(coord2,letterlist(p))
                        valid2 = 1;
                    else
                    end
                end
            end
            
            if isequal(coord2, letterlist(10))
                coord2tonum = 10;
            else
                for m = 1:9
                    if isequal(coord2, letterlist(m))
                        coord2tonum = m;
                    else
                    end
                end
            end
            
           % Check if on water. If not, allow player to reselect coordinates AND verify again                           
            onwater = verify(p2bs((coord2tonum + 1), (1 + 3*coord1)));
            while onwater == 0
                clc;
                fprintf('%s''s Territory\n', username2);
                disp(p2bs);
                
                valid = 0;                                          
                while valid == 0
                    coord1 = input('You must enter a coordinate on water!\n Why would you attack a point you''ve already hit or missed??\nEnter the number coordinate of your point of attack (1 - 10), Admiral!');
                    for p = 1:10
                        if coord1 == p
                            valid = 1;
                        else
                        end
                    end
                end
                
                valid2 = 0;
                while valid2 == 0
                    coord2 = input('Now, please enter the LETTER coordinate of your point of attack (A to J), in CAPS.','s');
                    for p = 1:10
                        if isequal(coord2,letterlist(p))
                            valid2 = 1;
                        else
                        end
                    end
                end
                
                if isequal(coord2, letterlist(10))
                coord2tonum = 10;
                else
                    for m = 1:9
                        if isequal(coord2, letterlist(m))
                            coord2tonum = m;
                        else
                        end
                    end
                end
                onwater = verify(p2bs((coord2tonum + 1), (1 + 3*coord1)));
            end
            opermrow = coord2tonum + 1;
            opermcol = 1 + 3*coord1;
            
            % Confirm coordinates, loop to ensure valid option chosen
            confirmatk = input('Are you sure of those coordinates of attack Admiral? Type (1) Yes and (2) No.');
            while confirmatk ~= 1 && confirmatk ~= 2
                confirmatk = ('Please choose a valid option! Are you sure of those coordinates Admiral? (1) Yes (2) No');
            end
            
            % Check hit or miss
            % Update win condition
            % Total number of ship parts: 5 + 4 + 3 + 3 + 2 = 17
            
            hitormiss = hit(opermrow,opermcol,p2b);
            if hitormiss == 1 && confirmatk == 1 && onwater == 1
                p2bs(opermrow, opermcol) = 'X';
                p1numhits = p1numhits + 1;
            elseif hitormiss == 0 && confirmatk == 1 && onwater == 1
                p2bs(opermrow, opermcol) = 'O';
            else
            end
            
            if p1numhits == 17
                whowon = 1;
            end
            
            end
            clc;
            p1turn = 0;
            fprintf('%s''s Territory\n', username2)
            disp(p2bs);
            if hitormiss == 1
                showhit = input('HIT! Nice shot, Type (1) to end your turn!');
                while showhit ~= 1
                    showhit = input('Type (1) to end your turn, commander.');
                end
            elseif hitormiss == 0
                showmiss = input('MISS! Better luck next time... Type (1) to end your turn!');
                while showmiss ~= 1
                    showmiss = input('Don''t be salty "Admiral"! Type (1) to end your turn!');
                end
            end
            p2turn = 1;
            
            %% Player 2 turn
        elseif p2turn == 1
            if mode == 2
                confirmatk = 0;
                while ~(confirmatk == 1) 
                clc;
                fprintf('Strategically decide your attack, %s.\n"X" signifies a hit, "O" signifies a miss\n', username2);
                fprintf('%s''s Territory\n', username1);
                disp(p1bs);
                
                valid = 0;                                          
                while valid == 0
                    coord1 = input('Enter the number coordinate of your point of attack (1 - 10), Admiral!');
                    for p = 1:10
                        if coord1 == p
                            valid = 1;
                        else
                        end
                    end
                end
                
                valid2 = 0;
                while valid2 == 0
                    coord2 = input('Now, Enter the LETTER coordinate of your point of attack (A to J), in CAPS.','s');
                    for p = 1:10
                        if isequal(coord2,letterlist(p))
                            valid2 = 1;
                        else
                        end
                    end
                end
                
                if isequal(coord2, letterlist(10))
                    coord2tonum = 10;
                else
                    for m = 1:9
                        if isequal(coord2, letterlist(m))
                            coord2tonum = m;
                        else
                        end
                    end
                end
                
               % Check if on water. If not, allow player to reselect coordinates AND verify again                           
                onwater = verify(p1bs((coord2tonum + 1), (1 + 3*coord1)));
                while onwater == 0
                    clc;
                    fprintf('%s''s Territory\n', username1);
                    disp(p1bs);
                    
                    valid = 0;                                          
                    while valid == 0
                        coord1 = input('You must enter a coordinate on water!\n Why would you attack a point you''ve already hit or missed??\nEnter the number coordinate of your point of attack (1 - 10), Admiral!');
                        for p = 1:10
                            if coord1 == p
                                valid = 1;
                            else
                            end
                        end
                    end
                    
                    valid2 = 0;
                    while valid2 == 0
                        coord2 = input('Now, please enter the LETTER coordinate of your point of attack (A to J), in CAPS.','s');
                        for p = 1:10
                            if isequal(coord2,letterlist(p))
                                valid2 = 1;
                            else
                            end
                        end
                    end
                    
                    if isequal(coord2, letterlist(10))
                    coord2tonum = 10;
                    else
                        for m = 1:9
                            if isequal(coord2, letterlist(m))
                                coord2tonum = m;
                            else
                            end
                        end
                    end
                    onwater = verify(p1bs((coord2tonum + 1), (1 + 3*coord1)));
                end
                opermrow = coord2tonum + 1;
                opermcol = 1 + 3*coord1;
                
                % Confirm coordinates, loop to ensure valid option chosen
                confirmatk = input('Are you sure of those coordinates of attack Admiral? Type (1) Yes and (2) No.');
                while confirmatk ~= 1 && confirmatk ~= 2
                    confirmatk = ('Please choose a valid option! Are you sure of those coordinates Admiral? (1) Yes (2) No');
                end
                
                % Check hit or miss
                % Update win condition
                % Total number of ship parts: 5 + 4 + 3 + 3 + 2 = 17
                
                hitormiss = hit(opermrow,opermcol,p1b);
                if hitormiss == 1 && confirmatk == 1 && onwater == 1
                    p1bs(opermrow, opermcol) = 'X';
                    p2numhits = p2numhits + 1;
                elseif hitormiss == 0 && confirmatk == 1 && onwater == 1
                    p1bs(opermrow, opermcol) = 'O';
                else
                end
                
                if p2numhits == 17
                    whowon = 2;
                end
                
                end
                
                clc;
                p2turn = 0;
                fprintf('%s''s Territory\n', username2)
                disp(p1bs);
                if hitormiss == 1
                    showhit = input('HIT! Nice shot, Type (1) to end your turn!');
                    while showhit ~= 1
                        showhit = input('Type (1) to end your turn, commander.');
                    end
                elseif hitormiss == 0
                    showmiss = input('MISS! Better luck next time... Type (1) to end your turn!');
                    while showmiss ~= 1
                        showmiss = input('Don''t be salty "Admiral"! Type (1) to end your turn!');
                    end
                end
                p1turn = 1;
                
                
                
                %% AI mode
            elseif mode == 1 && ask == 1
                
                
                %% Easy mode
                if difficulty == 1
                    coordrow = 1 + (floor(1+10*rand));
                    coordcol = 1 + 3*(floor(1+10*rand));
                    % Check if on water. If not, allow player to reselect coordinates AND verify again                           
                    onwater = verify(p1bs((coordrow), (coordcol)));
                    while onwater == 0
                        coordrow = 1 + (ceil(11*rand));
                        coordcol = 1 + 3*(ceil(11*rand));
                        onwater = verify(p1bs((coordrow), (coordcol)));
                    end
                    
                    
                    hitormiss = hit(coordrow, coordcol, p1b);
                    if hitormiss == 1
                        p1bs(coordrow,coordcol) = 'X';
                        
                        clc;
                        fprintf('%s''s Territory\n', username1);
                        disp(p1bs);
                        
                        showhit = input('Hit! Nice shot Admiral Vladimir! (1) Continue');                        
                        while showhit ~= 1
                            showhit = input('HIT! Nice shot Admiral Vladimir! (1) Continue'); 
                        end
                    elseif hitormiss == 0
                        p1bs(coordrow,coordcol) = 'O';
                        
                        clc;
                        fprintf('%s''s Territory\n', username1);
                        disp(p1bs);
                        
                        showmiss = input('Miss! You got lucky this time! (1) Continue');
                        while showmiss ~= 1
                            showmiss = input('Miss! You got lucky this time! (1) Continue');
                        end
                    end
                    
                    
                    %% Hard difficulty
                elseif difficulty == 2
                    if hittest == 1
                        
                        onwater2 = 0;
                        while onwater2 == 0
                            coinflip = floor(1+4*rand);
                            if coinflip == 1
                                coordrow = prevcoord1;
                                coordcol = prevcoord2 + 3;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow,coordcol,p1b) && onwater2 == 1
                                    horiz = 1;
                                    hittest = hittest + 1;
                                else
                                end
                            elseif coinflip == 2
                                coordrow = prevcoord1 + 1;
                                coordcol = prevcoord2;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow, coordcol, p1b) && onwater2 == 1
                                    vert = 1;
                                    hittest = hittest + 1;
                                else
                                end
                            elseif coinflip == 3
                                coordrow = prevcoord1 - 1;
                                coordcol = prevcoord2;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow,coordcol,p1b) && onwater2 == 1
                                    vert = 1;
                                    hittest = hittest + 1;
                                end
                            elseif coinflip == 4
                                coordrow = prevcoord1;
                                coordcol = prevcoord2 - 3;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow, coordcol, p1b) && onwater2 == 1
                                    horiz = 1;
                                    hittest = hittest + 1;
                                end
                            end
                        end
                    elseif horiz == 1 && hittest > 1
                        onwater2 = 0;
                        while onwater2 == 0
                            if isequal(p1bs(prevcoord1,prevcoord2), 'X') && isequal(p1bs(prevcoord1,prevcoord2 - 3), 'X')
                                coordrow = prevcoord1;
                                coordcol = prevcoord2 + 3;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow, coordcol, p1b) && onwater2 == 1
                                    horiz = 1;
                                    hittest = hittest + 1;
                                end
                            elseif isequal(p1bs(prevcoord1,prevcoord2), 'X') && isequal(p1bs(prevcoord1,prevcoord2 + 3), 'X')
                                coordrow = prevcoord1;
                                coordcol = prevcoord2 - 3;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow, coordcol, p1b) && onwater2 == 1
                                    horiz = 1;
                                    hittest = hittest + 1;
                                end
                            end
                        end
                    elseif vert == 1 && hittest > 1
                        onwater2 = 0;
                        while onwater2 == 0
                            if isequal(p1bs(prevcoord1,prevcoord2), 'X') && isequal(p1bs(prevcoord1 - 1,prevcoord2), 'X')
                                coordrow = prevcoord1 + 1;
                                coordcol = prevcoord2;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow, coordcol, p1b) && onwater2 == 1
                                    vert = 1;
                                    hittest = hittest + 1;
                                end
                            elseif isequal(p1bs(prevcoord1,prevcoord2), 'X') && isequal(p1bs(prevcoord1 + 1 ,prevcoord2), 'X')
                                coordrow = prevcoord1 - 1;
                                coordcol = prevcoord2;
                                onwater2 = verify(p1bs((coordrow), (coordcol)));
                                if hit(coordrow, coordcol, p1b) && onwater2 == 1
                                    vert = 1;
                                    hittest = hittest + 1;
                                end
                            end
                        end
                    elseif hittest == 0
                        onwater2 = 0;
                        while onwater2 == 0
                            coordrow = 1 + (ceil(10*rand));
                            coordcol = 1 + 3*(ceil(10*rand));
                            onwater2 = verify(p1bs((coordrow), (coordcol)));
                        end
                        if hit(coordrow,coordcol, p1b) == 1 && onwater2 == 1
                                hittest = hittest + 1;
                         elseif hit(coordrow,coordcol, p1b) == 0 && onwater2 == 1
                                hittest = 0;
                        end
                    end
                    
                    hitormiss = hit(coordrow, coordcol, p1b);
                    if hitormiss == 1
                        p1bs(coordrow,coordcol) = 'X';
                        
                        clc;
                        fprintf('%s''s Territory\n', username1);
                        disp(p1bs);
                        showhit = input('Hit! Nice shot Admiral Vladimir! (1) Continue');
                        p2numhits = p2numhits + 1;
                        while showhit ~= 1
                            showhit = input('HIT! Nice shot Admiral Vladimir! (1) Continue'); 
                        end
                    elseif hitormiss == 0
                        p1bs(coordrow,coordcol) = 'O';
                        
                        clc;
                        fprintf('%s''s Territory\n', username1);
                        disp(p1bs);
                        showmiss = input('Miss! You got lucky this time! (1) Continue');
                        while showmiss ~= 1
                            showmiss = input('Miss! You got lucky this time! (1) Continue');
                        end
                    end
                end
                if hit(coordrow,coordcol,p1b) == 1
                    prevcoord1 = coordrow;
                    prevcoord2 = coordcol;
                elseif isequal(p1b(coordrow,coordcol),'#') && hittest == 5
                    hittest = 0;
                elseif isequal(p1b(coordrow,coordcol),'@') && hittest == 4
                    hittest = 0;
                elseif isequal(p1b(coordrow,coordcol),'%') && hittest == 3
                    hittest = 0;
                elseif isequal(p1b(coordrow,coordcol),'&') && hittest == 3
                    hittest = 0;
                elseif isequal(p1b(coordrow,coordcol),'$') && hittest == 2
                    hittest = 0;
                end
               
                p2turn = 0;
                p1turn = 1;
                
                if p2numhits == 17
                    whowon = 2;
                end

            end
            
            
        end
        %% Display who won
            if whowon == 1 && mode == 2
                clc;
                fprintf('CONGRAGULATIONS ADMIRAL %s! YOU''VE DEMOLISHED %s!!',username1,username2);
            elseif whowon == 2 && mode == 2
                clc;
                fprintf('CONGRAGULATIONS ADMIRAL %s! YOU''VE DEMOLISHED %s!!',username2,username1);
            elseif mode == 1 && whowon == 1
                fprintf('CONGRAGULATIONS ADMIRAL %s! YOU''VE DEMOLISHED ADMIRAL VLADIMIR!!',username1);
            elseif mode == 1 && whowon == 2
                fprintf('DEFEAT! THE RUSSIAN ADMIRAL VLADIMIR HAS DISMANTLED YOUR FORCES, COMMANDER %s\nhttps://www.youtube.com/watch?v=pBTI6h7zHwM',username1);
            end
            
    end
    fprintf( ...
    ['                         ==^==\n' ...
    '                    _____/|#|//___:\n' ...
    '    ________|______/__0__/____0_0_|____/______\n' ...
    '   (     0      0   ,   0   ,   ````   0       )\n' ...
    '~~~~~~~`~~~~`~~`~~~`~~`~~`~~`~~`~~~`~~~~`~~`~`~~~~~~\n\n']);
    gameover = input('Play again? Type (1) Yes (2) No');
    while gameover ~= 1 && gameover ~= 2
        gameover = input('Play again? Type (1) Yes (2) No');
    end
end








%%%%%%%%%%%%%%%%%%%%%%%  Functions  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% WATER ONLY CHECKER
function trueorfalse = verify(c1)
    % Make sure ship placement is not on top of existing ship and remains
    % on the board
    if ~(isequal(c1,'~'))
        trueorfalse = 0;
    else
        trueorfalse = 1;
    end
end

% hit?? returns 1 if hit, 0 if not, compare primary and secondary boards
function yesorno = hit(row, col, primary)
    if isequal(primary(row,col), '@') || isequal(primary(row,col), '#') || isequal(primary(row,col), '%') || isequal(primary(row,col), '&') || isequal(primary(row,col), '$')
        yesorno = 1;
    else
        yesorno = 0;
    end
end

 % Clears the selected board of a specific character
function clearedboard = clearboard(board,char)
    for row = 2:11
        for col = 3:33
            if board(row,col) == char
                board(row,col) = '~';
            end
        end
    end
    clearedboard = board;
end