clc
clear all
close all

[voice,Fs]=audioread('06LittleWing.wav');

player = audioplayer(voice,Fs) ;
play(player)

buffer=voice(1:2205);
% buffer=voice(1:882);

buffer_f=fftshift(fft(buffer));   
% sound(voice,Fs)       

t=linspace(0,(length(buffer)-1)/Fs,length(buffer));
f=linspace(-Fs/2,Fs/2,length(buffer_f));

bufferplotstep=840;
%         subplot(3,1,1)
        plot(f,buffer)
        title('Recording Time Domain')
        xlabel('Time [Sec]')
        ylabel('Voltage [V]')
        grid on
        
% distorion_gain=4;
% distortion_level=3;
% distortion(voice,distorion_gain,distortion_level);


for i= 15000:bufferplotstep:length(voice)
    tic;
    buffer=circshift(buffer,bufferplotstep);
    buffer(1:bufferplotstep)=voice(i:i+bufferplotstep-1);
    buffer_f=abs(fftshift(fft(buffer)));
    figure(1)
    subplot(2,1,1);
    plot(f(1102:length(buffer)),buffer_f(1102:length(buffer)))
    xlim([0 20000]);
    subplot(2,1,2);
    plot(t,buffer)
    ylim([-0.8 0.8])
    drawnow
  if toc<0.04
      bufferplotstep=round(toc/(1/Fs)); 
  end
  toc
end

% 