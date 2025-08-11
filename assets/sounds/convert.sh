
mkdir -p orig

for f in *.wav; do
    # Rename original file with "orig_" prefix and move to orig/
    mv "$f" "orig/orig_$f"

    # Process from orig/ back to current dir with original filename (no prefix)
    ffmpeg -i "orig/orig_$f" \
	-af "volume=12dB, \
	     silenceremove=start_periods=1:start_threshold=-50dB:start_silence=0.1:stop_periods=1:stop_threshold=-50dB:stop_silence=0.2, \
	     afftdn=nf=-25, \
	     equalizer=f=180:t=q:w=1:g=-3, \
	     highpass=f=120, \
	     treble=g=4, \
	     acompressor=threshold=-12dB:ratio=2.5:attack=5:release=50" \
    -ar 8000 -ac 1 -acodec pcm_u8 "$f"
done

rm -rf orig

#           silenceremove=start_periods=1:start_threshold=-50dB:start_silence=0.1:stop_periods=1:stop_threshold=-50dB:stop_silence=0.2, \
#           afftdn=nf=-25, \
#           equalizer=f=180:t=q:w=1:g=-3, \
#           highpass=f=120, \
#           treble=g=4, \
#           acompressor=threshold=-12dB:ratio=2.5:attack=5:release=50" \
