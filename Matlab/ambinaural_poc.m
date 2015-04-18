%% b format tests 17.04.15
% hohnerlein ilse

%% Setup
writeHRTFs = true;
writeSimpleBeamform = false;
writeAmbinaural = false;
plotSignals = false;

%% read input into WXYZ
disp('Reading input files')
[t, ~] = audioread('data/input/b-format WX.mp3');
X=t(:,1);
W=t(:,2);
[t, fs] = audioread('data/input/b-format YZ.mp3');
Y=t(:,1);
Z=t(:,2);

%% read hrirs
disp('Reading HRTFs')
hrirs = load('/data/hrtf/kemar/subject_021/hrir_final.mat');

% Fetch 6 static hrtfs with getNearestUCDpulse(azimuth,elevation,hrirs);
disp('Fetching necessary HRTFs')

% left
hrir_left_r  = getNearestUCDpulse(-90,0,hrirs.hrir_r);
hrir_left_l  = getNearestUCDpulse(-90,0,hrirs.hrir_l);

% right
hrir_right_r = getNearestUCDpulse(90,0,hrirs.hrir_r);
hrir_right_l = getNearestUCDpulse(90,0,hrirs.hrir_l);

% front
hrir_front_r = getNearestUCDpulse(0,0,hrirs.hrir_r);
hrir_front_l = getNearestUCDpulse(0,0,hrirs.hrir_l);

% back
hrir_back_r  = getNearestUCDpulse(0,180,hrirs.hrir_r);
hrir_back_l  = getNearestUCDpulse(0,180,hrirs.hrir_l);

% up
hrir_up_r  = getNearestUCDpulse(0,90,hrirs.hrir_r);
hrir_up_l  = getNearestUCDpulse(0,90,hrirs.hrir_l);

% down
hrir_down_r  = getNearestUCDpulse(0,-90,hrirs.hrir_r);
hrir_down_l  = getNearestUCDpulse(0,-90,hrirs.hrir_l);

if writeHRTFs
    disp('Writing HRTFs')
    
    audiowrite('data/hrtf/hrir_left_r.wav',hrir_left_r,fs);
    audiowrite('data/hrtf/hrir_left_l.wav',hrir_left_l,fs);
    
    audiowrite('data/hrtf/hrir_right_r.wav',hrir_right_r,fs);
    audiowrite('data/hrtf/hrir_right_l.wav',hrir_right_l,fs);
    
    audiowrite('data/hrtf/hrir_front_r.wav',hrir_front_r,fs);
    audiowrite('data/hrtf/hrir_front_l.wav',hrir_front_l,fs);
    
    audiowrite('data/hrtf/hrir_back_r.wav',hrir_back_r,fs);
    audiowrite('data/hrtf/hrir_back_l.wav',hrir_back_l,fs);
    
    audiowrite('data/hrtf/hrir_up_r.wav',hrir_up_r,fs);
    audiowrite('data/hrtf/hrir_up_l.wav',hrir_up_l,fs);
    
    audiowrite('data/hrtf/hrir_down_r.wav',hrir_down_r,fs);
    audiowrite('data/hrtf/hrir_down_l.wav',hrir_down_l,fs);
end

%% Get audio
disp('Generate audio material')
% Azimuth of head turn
theta = pi/2;

% Elevation of head turn
phi = 0;

% Get 6 correct channels from b format
%right
sig_r = sqrt(2) * W + X * cos(theta + pi/2) * cos(phi) + Y * sin(theta + pi/2) * cos(phi) + Z * sin(phi);
%left
sig_l = sqrt(2) * W + X * cos(theta - pi/2) * cos(phi) + Y * sin(theta - pi/2) * cos(phi) + Z * sin(phi);
%front
sig_f = sqrt(2) * W + X * cos(theta) * cos(phi) + Y * sin(theta) * cos(phi) + Z * sin(phi);
%back
sig_b = sqrt(2) * W + X * cos(-theta) * cos(phi) + Y * sin(-theta) * cos(phi) + Z * sin(phi);
%up
sig_u = sqrt(2) * W + X * cos(theta) * cos(phi + pi/2) + Y * sin(theta) * cos(phi + pi/2) + Z * sin(phi + pi/2);
%down
sig_d = sqrt(2) * W + X * cos(theta) * cos(phi - pi/2) + Y * sin(theta) * cos(phi - pi/2) + Z * sin(phi - pi/2);

dry = [sig_l, sig_l];

% Normalize
dry = dry/max(abs(dry(:)));

if writeSimpleBeamform
    p_dry = audioplayer(dry,fs);
end

%% Convolve with HRTF
% TODO: user matrices and conv2
disp('Convolving audio with HRTFs')

% Left ear
leftear_right = conv( sig_r , hrir_right_l);
leftear_left  = conv( sig_l , hrir_left_l);
leftear_front = conv( sig_f , hrir_front_l);
leftear_back  = conv( sig_b , hrir_back_l);
leftear_up    = conv( sig_u , hrir_up_l);
leftear_down  = conv( sig_d , hrir_down_l);

% right ear
rightear_right = conv( sig_r , hrir_right_r);
rightear_left  = conv( sig_l , hrir_left_r);
rightear_front = conv( sig_f , hrir_front_r);
rightear_back  = conv( sig_b , hrir_back_r);
rightear_up    = conv( sig_u , hrir_up_r);
rightear_down  = conv( sig_d , hrir_down_r);

% Scale ouput by number of inputs
disp('Finishing up')
leftear = (leftear_right + leftear_left + leftear_front + leftear_back + leftear_up + leftear_down) / 6;
rightear = (rightear_right + rightear_left + rightear_front + rightear_back + rightear_up + rightear_down) / 6;

final = [leftear, rightear];

% Normalize
final = final / max(abs(final(:)));

p_hrtf = audioplayer(final,fs);

if writeAmbinaural
    disp('Writing output files')
    audiowrite('out/hrtf.wav',final,fs);
    audiowrite('out/dry.wav',dry,fs);
end

if plotSignals
    disp('Plotting')
    
    t = (0:length(sig_r)-1)/fs;

    plot(t,sig_r)
    hold on
    plot(t,sig_l)

    p_r = audioplayer(sig_r,fs)
    p_l = audioplayer(sig_l,fs)
end

disp('All done!')