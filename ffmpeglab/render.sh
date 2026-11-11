ffmpeg \
-i "$MEDIA_1" \
-i "$MEDIA_2" \
-i "$MEDIA_3" \
-i "$MEDIA_4" \
-i "$MEDIA_5" \
-i "$MEDIA_6" \
-crf 25 \
-filter_complex "
[0:v]loop=loop=86.39999999999999:size=1:start=0,setdar=9/16,scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,colorchannelmixer=rr=1:gg=1:bb=1:aa=1[v0];
[1:v]loop=loop=150:size=1:start=0,setdar=9/16,scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,colorchannelmixer=rr=1:gg=1:bb=1:aa=1[v1];
[2:v]loop=loop=150:size=1:start=0,setdar=9/16,scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,colorchannelmixer=rr=1:gg=1:bb=1:aa=1[v2];
[3:v]loop=loop=150:size=1:start=0,setdar=9/16,scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,colorchannelmixer=rr=1:gg=1:bb=1:aa=1[v3];
[4:v]loop=loop=150:size=1:start=0,setdar=9/16,scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,colorchannelmixer=rr=1:gg=1:bb=1:aa=1[v4];
[5:v]loop=loop=99:size=1:start=0,setdar=9/16,scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,colorchannelmixer=rr=1:gg=1:bb=1:aa=1[v5];
[v0]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1[c0];
[v1]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1[c1];
[v2]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1[c2];
[v3]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1[c3];
[v4]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1[c4];
[v5]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1[c5];
[c0][c1]hstack=inputs=2[row0];
[c2][c3]hstack=inputs=2[row1];
[c4][c5]hstack=inputs=2[row2];
[row0][row1][row2]vstack=inputs=3[grid];
[grid]settb=expr=1/30[v_concat];
aevalsrc=0:d=2.88[s0];
aevalsrc=0:d=5[s1];
aevalsrc=0:d=5[s2];
aevalsrc=0:d=5[s3];
aevalsrc=0:d=5[s4];
aevalsrc=0:d=3.3[s5];
[s0]adelay=delays=0|0,volume=1[a0];
[s1]adelay=delays=2880|2880,volume=1[a1];
[s2]adelay=delays=7880|7880,volume=1[a2];
[s3]adelay=delays=12879.999999999998|12879.999999999998,volume=1[a3];
[s4]adelay=delays=17880|17880,volume=1[a4];
[s5]adelay=delays=22880|22880,volume=1[a5];
[a0][a1][a2][a3][a4][a5]amix=inputs=6:duration=longest[a_concat]
" \
-movflags +faststart \
-map "[v_concat]" \
-map "[a_concat]" \
-r 30 \
-ss 00:00:00 \
-to 00:00:19 \
-y \
"$OUTPUT_PATH"
