function alarm_sound()
    Fs = 8000;          % sample rate (Hz)
    t  = 0:1/Fs:0.5;   % 0.5 second duration

    % mix two tones for a more alarming sound
    signal = sin(2 * pi * 880 * t) + sin(2 * pi * 1200 * t);

    % normalise to [-1, 1] so sound() doesn't clip
    signal = signal / max(abs(signal));

    sound(signal, Fs);
end