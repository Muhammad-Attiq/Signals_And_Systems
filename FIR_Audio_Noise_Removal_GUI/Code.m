function audio_filter_gui_fir_sidebar
    % Initialize default sampling rate and audio buffers
    Fs = 44100; 
    raw_audio = []; 
    filtered_audio = [];

    % Create GUI figure window
    f = figure('Name','FIR Audio Noise Removal Studio','Position',[100 100 1000 600],'Color',[0.1 0.1 0.2]);

    % Create sidebar panel for controls
    sidebar = uipanel(f,'Position',[0 0 0.16 1],'Title','Controls','BackgroundColor',[0.2 0.3 0.5],'FontWeight','bold','ForegroundColor','white','FontSize',12);

    % Status text box
    statusText = uicontrol(sidebar,'Style','text','String','Status: ? Waiting...','Units','normalized','Position',[0.1 0.15 0.8 0.06],'HorizontalAlignment','left','BackgroundColor',[0.2 0.3 0.5],'FontSize',10,'ForegroundColor',[0.9 0.9 1]);

    % Anonymous function for creating buttons easily
    btnStyle = @(str,pos,cb,color) uicontrol(sidebar,'Style','pushbutton','String',str,'Units','normalized','Position',pos,'Callback',cb,'BackgroundColor',color,'FontWeight','bold','ForegroundColor','white','FontSize',10);

    % Create buttons for audio operations
    btnStyle('Load Audio',[0.1 0.98 0.8 0.05],@loadAudio,[0.2 0.7 0.6]);
    btnStyle('Record Audio',[0.1 0.92 0.8 0.05],@recordAudio,[0.1 0.6 0.8]);
    btnStyle('Play Original',[0.1 0.85 0.8 0.05],@playOriginal,[0.2 0.5 0.8]);
    btnStyle('Play Filtered',[0.1 0.78 0.8 0.05],@playFiltered,[0.3 0.4 0.8]);

    % Filter type dropdown
    uicontrol(sidebar,'Style','text','String','Filter Type:','Units','normalized','Position',[0.1 0.7 0.8 0.04],'HorizontalAlignment','left','BackgroundColor',[0.2 0.3 0.5],'FontSize',11,'FontWeight','bold','ForegroundColor',[1 1 1]);
    filterTypeMenu = uicontrol(sidebar,'Style','popupmenu','String',{'Lowpass','Highpass','Bandpass','Bandstop'},'Units','normalized','Position',[0.1 0.65 0.8 0.05],'BackgroundColor',[1 1 1],'FontSize',10,'ForegroundColor',[0.2 0.2 0.5]);

    % Cutoff frequency 1
    uicontrol(sidebar,'Style','text','String','Cutoff 1 (Hz):','Units','normalized','Position',[0.1 0.58 0.8 0.04],'HorizontalAlignment','left','BackgroundColor',[0.2 0.3 0.5],'FontSize',11,'FontWeight','bold','ForegroundColor',[1 1 1]);
    cutoff1Edit = uicontrol(sidebar,'Style','edit','String','300','Units','normalized','Position',[0.1 0.53 0.8 0.05],'BackgroundColor','white','FontSize',10);

    % Cutoff frequency 2 (used only in Bandpass and Bandstop)
    uicontrol(sidebar,'Style','text','String','Cutoff 2 (Hz):','Units','normalized','Position',[0.1 0.46 0.8 0.04],'HorizontalAlignment','left','BackgroundColor',[0.2 0.3 0.5],'FontSize',11,'FontWeight','bold','ForegroundColor',[1 1 1]);
    cutoff2Edit = uicontrol(sidebar,'Style','edit','String','3400','Units','normalized','Position',[0.1 0.41 0.8 0.05],'BackgroundColor','white','FontSize',10);

    % Filter length (order)
    uicontrol(sidebar,'Style','text','String','FIR Length:','Units','normalized','Position',[0.1 0.34 0.8 0.04],'HorizontalAlignment','left','BackgroundColor',[0.2 0.3 0.5],'FontSize',11,'FontWeight','bold','ForegroundColor',[1 1 1]);
    filterLengthEdit = uicontrol(sidebar,'Style','edit','String','301','Units','normalized','Position',[0.1 0.29 0.8 0.05],'BackgroundColor','white','FontSize',10);

    % Filter and save buttons
    btnStyle('Apply FIR Filter',[0.1 0.2 0.8 0.06],@filterAudio,[0 0.5 0.7]);
    btnStyle('Save Audio',[0.1 0.12 0.8 0.06],@saveAudio,[0 0.6 0.4]);

    % Create four axes for plots
    axColor = [0.1 0.1 0.2]; labelColor = [0.8 1 1];
    w = 0.4; h = 0.4; x1 = 0.17; x2 = x1 + w + 0.05; y1 = 0.55; y2 = y1 - h - 0.07;
    ax1 = axes('Units','normalized','Position',[x1 y1 w h],'Color',axColor,'XColor',labelColor,'YColor',labelColor); % Time domain
    ax2 = axes('Units','normalized','Position',[x2 y1 w h],'Color',axColor,'XColor',labelColor,'YColor',labelColor); % Frequency domain
    ax3 = axes('Units','normalized','Position',[x1 y2 w h],'Color',axColor,'XColor',labelColor,'YColor',labelColor); % Magnitude response
    ax4 = axes('Units','normalized','Position',[x2 y2 w h],'Color',axColor,'XColor',labelColor,'YColor',labelColor); % Phase response
    set([ax1, ax2, ax3, ax4],'NextPlot','add');
    title(ax1,'Time Domain','Color',[0 1 1]); grid(ax1,'on');
    title(ax2,'Frequency Domain','Color',[0 1 1]); ylabel(ax2,'Magnitude'); grid(ax2,'on');
    title(ax3,'Magnitude Response','Color',[0 1 0]); xlabel(ax3,'Frequency (Hz)'); grid(ax3,'on');
    title(ax4,'Phase Response','Color',[0 1 0]); xlabel(ax4,'Frequency (Hz)'); grid(ax4,'on');

    %% FILTER AUDIO FUNCTION
    function filterAudio(~,~)
        % Check if any audio is loaded
        if isempty(raw_audio), set(statusText,'String','No audio to filter!'); return; end

        % Get user-selected filter settings
        types = get(filterTypeMenu,'String'); 
        type = types{get(filterTypeMenu,'Value')};
        f1 = str2double(get(cutoff1Edit,'String'));
        f2 = str2double(get(cutoff2Edit,'String'));
        N = str2double(get(filterLengthEdit,'String'));

        % Check for valid filter length
        if isnan(N) || N < 51 || mod(N,2)==0
            set(statusText,'String','Invalid FIR Length'); return;
        end

        % Validate cutoff frequency 1
        if isnan(f1) || f1 <= 0 || f1 >= Fs/2
            set(statusText,'String','Cutoff 1 invalid!'); return;
        end

        % Validate cutoff 2 if using bandpass/bandstop
        if any(strcmp(type,{'Bandpass','Bandstop'})) && (isnan(f2) || f2 <= f1 || f2 >= Fs/2)
            set(statusText,'String','Cutoff 2 invalid!'); return;
        end

        % Pre-filtering: high-pass to remove DC and hum
        x = filter(fir1(100,40/(Fs/2),'high'),1,raw_audio); 
        x = filter([1 -0.97],1,x); % Remove DC drift
        x = x / max(abs(x)); % Normalize
        x(abs(x)<0.02)=0; % Remove small noise signals (soft threshold)

        nyq = Fs/2; % Nyquist frequency
        beta = 5; % Kaiser window beta parameter (sharpness)

        % Design FIR filter based on type
        switch type
            case 'Lowpass'
                coeffs = fir1(N-1, f1/nyq, 'low', kaiser(N,beta));
            case 'Highpass'
                coeffs = fir1(N-1, f1/nyq, 'high', kaiser(N,beta));
            case 'Bandpass'
                coeffs = fir1(N-1, [f1 f2]/nyq, 'bandpass', kaiser(N,beta));
            case 'Bandstop'
                coeffs = fir1(N-1, [f1 f2]/nyq, 'stop', kaiser(N,beta));
        end

        % Apply FIR filter
        y = filter(coeffs,1,x); 
        y = y - mean(y); % Center around zero
        y = y / max(abs(y)) * 0.98; % Normalize again
        filtered_audio = y;

        % Plot frequency response (Magnitude and Phase)
        [h,fq] = freqz(coeffs,1,2048,Fs);
        cla(ax3); plot(ax3,fq,20*log10(abs(h)+eps),'g','LineWidth',1.5); % Magnitude
        cla(ax4); plot(ax4,fq,unwrap(angle(h)),'m','LineWidth',1.5);     % Phase

        % Plot time-domain signals (original + filtered)
        t = (0:length(y)-1)/Fs;
        cla(ax1); plot(ax1,t,raw_audio,'c:',t,y,'g','LineWidth',1.2);
        legend(ax1,'Original','Filtered','TextColor','white');

        % Plot frequency domain (smoothed spectrum)
        Yf = abs(fft(y)); 
        f = Fs*(0:length(Yf)/2)/length(Yf);
        g = exp(-linspace(-7.5,7.5,15).^2/(2*4^2)); g = g/sum(g); % Gaussian smoother
        cla(ax2); plot(ax2,f,conv(Yf(1:length(f)),g,'same'),'y','LineWidth',1.2);

        % Update status
        set(statusText,'String','FIR filter applied');
    end

    %% RECORD AUDIO FUNCTION
    function recordAudio(~,~)
        r = audiorecorder(Fs,16,1); % Start audio recorder
        set(statusText,'String','Recording...'); pause(0.2);
        recordblocking(r,5); % Record 5 seconds
        raw_audio = getaudiodata(r); % Get audio data
        set(statusText,'String','Recording complete!');
        cla(ax1); plot(ax1,(0:length(raw_audio)-1)/Fs,raw_audio,'c','LineWidth',1.2);
        title(ax1,'Original Audio (Time)','Color',[0 1 1]);
        cla(ax2); cla(ax3); cla(ax4); % Clear other plots
    end

    %% LOAD AUDIO FUNCTION
    function loadAudio(~,~)
        [file,path] = uigetfile({'*.wav;*.mp3','Audio Files'});
        if isequal(file,0)
            set(statusText,'String','Load cancelled.'); return;
        end
        [raw_audio,Fs] = audioread(fullfile(path,file)); % Load and read audio
        raw_audio = raw_audio(:,1); % Use mono channel if stereo
        set(statusText,'String',['Loaded: ',file]);
        cla(ax1); plot(ax1,(0:length(raw_audio)-1)/Fs,raw_audio,'c','LineWidth',1.2);
        title(ax1,'Loaded Audio (Time)','Color',[0 1 1]); cla(ax2); cla(ax3); cla(ax4);
    end

    %% PLAY ORIGINAL AUDIO
    function playOriginal(~,~)
        if isempty(raw_audio)
            set(statusText,'String','No original audio!'); return;
        end
        set(statusText,'String','Playing original...'); sound(raw_audio,Fs);
    end

    %% PLAY FILTERED AUDIO
    function playFiltered(~,~)
        if isempty(filtered_audio)
            set(statusText,'String','No filtered audio!'); return;
        end
        set(statusText,'String','Playing filtered...'); sound(filtered_audio,Fs);
    end

    %% SAVE FILTERED AUDIO TO FILE
    function saveAudio(~,~)
        if isempty(filtered_audio)
            set(statusText,'String','No audio to save!'); return;
        end
        [file,path] = uiputfile('filtered_audio.wav','Save Filtered Audio As');
        if isequal(file,0)
            set(statusText,'String','Save cancelled.'); return;
        end
        audiowrite(fullfile(path,file),filtered_audio,Fs);
        set(statusText,'String',['Saved to ',fullfile(path,file)]);
    end
end
