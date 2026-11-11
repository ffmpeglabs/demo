ffmpeg \
-i "$MEDIA_1" \
-i "$MEDIA_2" \
-i "$MEDIA_3" \
-i "$MEDIA_4" \
-i "$MEDIA_5" \
-i "$MEDIA_6" \
-crf 25 \
-filter_complex "\
[0:v]setdar=9/16,scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p,loop=loop=86:size=1:start=0[v0];\
[1:v]setdar=9/16,scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p,loop=loop=150:size=1:start=0[v1];\
[2:v]setdar=9/16,scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p,loop=loop=150:size=1:start=0[v2];\
[3:v]setdar=9/16,scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p,loop=loop=150:size=1:start=0[v3];\
[4:v]setdar=9/16,scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p,loop=loop=150:size=1:start=0[v4];\
[5:v]setdar=9/16,scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p,loop=loop=99:size=1:start=0[v5];\
[v0][v1][v2][v3][v4][v5]xstack=inputs=6:layout=0_0|w0_0|0_h0|w0_h0|0_h0+h0|w0_h0+h0[v_grid];\
[v_grid]scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=1/30,format=yuv420p[v_concat];\
aevalsrc=0:d=2.88[s0];[s0]adelay=delays=0|0,volume=1[a0];\
aevalsrc=0:d=5[s1];[s1]adelay=delays=2880|2880,volume=1[a1];\
aevalsrc=0:d=5[s2];[s2]adelay=delays=7880|7880,volume=1[a2];\
aevalsrc=0:d=5[s3];[s3]adelay=delays=12880|12880,volume=1[a3];\
aevalsrc=0:d=5[s4];[s4]adelay=delays=17880|17880,volume=1[a4];\
aevalsrc=0:d=3.3[s5];[s5]adelay=delays=22880|22880,volume=1[a5];\
[a0][a1][a2][a3][a4][a5]amix=inputs=6:duration=longest[a_concat]" \
-movflags +faststart \
-map "[v_concat]" \
-map "[a_concat]" \
-r 30 \
-ss 00:00:00 \
-to 00:00:19 \
-y \
"$OUTPUT_PATH"
