%==========================================================================
%  2M Dynamics and Vibration Illustration of inertance FRF
%  F. Cegla 23/02/11
%==========================================================================

%Input parameters
f=[10:0.01:25];  % freq range in Hz 1 Hz increments
m1=1; % mass    in kg
f1= 15;  %hz
c1=0.4 ;  % viscous damping ratio

w=2*pi*f; % rad /sec
w1=2*pi*f1; % res freq, rad/sec
k1=m1*w1*w1; % hence stiffness k1 in N/m

%calculate magnitude and phase of a/F FRF
mag=1./sqrt((m1-k1./w.^2).^2+(c1./w).^2);
ph=atan2(c1./w,(m1-k1./w.^2));
phase=ph.*180/pi;  %convert to degrees

%deduce real and imaginary part of the response and compute complex FRF h
rinert= mag.*cos(ph);
iinert=mag.*sin(ph);
h=complex(rinert,iinert)


%==========================================================================
%Plot results
%==========================================================================
% define a plot with three subplot regions and make the top on active
SS=get(0,'Screensize');
figure('Position',SS)
h0a=subplot(2,2,1);
semilogy(f,mag,'r','Linewidth',2) %plot receptance of mass1
xlabel('Frequency Hz','Fontsize',14)
ylabel('Log Inertance (log (a/F)) ','Fontsize',14)
FRFylim=[min(min(abs(mag))) max(max(abs(mag)))];
%ylim(FRFylim)
grid on
%plot sketch of the system
subplot(2,2,3)
plot(f,phase,'g','Linewidth',2)
grid on
xlabel('Frequency Hz','Fontsize',14)
ylabel('Phase (deg) ','Fontsize',14)

% plot a nyquist plot
h0c=subplot(2,2,2);
plot (rinert,iinert,'r+-')
xlabel(' Real Part')
ylabel ('imag part')
title(' Nyquist Plot of SDOF')
grid on
xlabel('Real axis','Fontsize',14)
ylabel('Imaginary axis ','Fontsize',14)
title('Nyquist plot','Fontsize',14)

% Inform user of who to use the demo
instructions=helpdlg(strcat('Click at a point in the top left graph to select a frequency',...
    ' at which the force and acceleration time histories are simulated in the bottom right plot.',...
    'Press any key to exit'));
waitfor(instructions)

%==========================================================================
%Loop for interaction with the user
%==========================================================================
w=0; % define entry condition to the while loop
fselection=0; %turn to 1 if frequency has been selected
while w==0
    % catch the location of where the mouse is clicked
    % if a key is pressed exit the program
    w=waitforbuttonpress;
    if w == 0
        disp('Button click')
    else
        disp('Key press')
        close all
        break
    end
    
    
    % extract the selected frequency where the mouse was clicked
    frequest=get(h0a,'CurrentPoint');
    fchoice=frequest(1,1)
    [val,fchoice_index]=min(abs(frequest(1,1)-f));
    
    if fchoice<f(1)
        %fchoice=f(10)
        fchoice_index=10;
    end
    if fchoice>f(end)
        %fchoice=f(end-10)
        fchoice_index=length(f)-10;
    end
    
    omega=2*pi*frequest(1,1);
    
    % indicate selected frequency on FRF and Nyquist plots
    if fselection ==1
        %update lines if they already exist
        
        set(hl1,'XData',[f(fchoice_index) f(fchoice_index)]);
        set(hl2,'XData',[0 real(h(fchoice_index))]);
        set(hl2,'YData',[0 imag(h(fchoice_index))]);
    else
        %create lines in case they do not already exist
        
        h0a=subplot(2,2,1);
        hl1=line([f(fchoice_index) f(fchoice_index)],FRFylim,'Color',[0 0 0 ],'Linewidth',2);
        h0c=subplot(2,2,2);
        hl2=line([0 real(h(fchoice_index))],[0 imag(h(fchoice_index))],'Color',[0 0 0 ],'Linewidth',2);
        fselection=1;
        
    end
    
    % set bottom plot to current
    h0b=subplot(2,2,4);
    % update the selected frequency in the title
    title(strcat('Time signals at:  ',num2str(f(fchoice_index)),' Hz'),'Fontsize',16)
    
    % Plot time histories
    t=0:1/f(fchoice_index)/20:3/f(fchoice_index);
    F=cos(omega.*t); %define Force
    x1=mag(fchoice_index).*cos(omega.*t+phase(fchoice_index)/180*pi)/100;
    plot(t,F,'r')
    hold
    plot(t,x1,'g')
    hold
    xlabel('Time (secs)','Fontsize',14)
    ylabel('Amp.(N-red; hundreds of m/s2 - green)','Fontsize',14)
    
end

