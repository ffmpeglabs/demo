#!/usr/bin/env bash
set -euo pipefail

ffmpeg \
-i "$MEDIA_1" \
-i "$MEDIA_2" \
-i "$MEDIA_3" \
-i "$MEDIA_4" \
-i "$MEDIA_5" \
-i "$MEDIA_6" \
-crf 25 \
-filter_complex "
[0:v]setdar=9/16,scale=356:640:force_original_aspect_ratio=decrease,pad=356:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,trim=duration=5,setpts=PTS-STARTPTS[v0];
[1:v]setdar=9/16,scale=356:640:force_original_aspect_ratio=decrease,pad=356:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,trim=duration=5,setpts=PTS-STARTPTS[v1];
[2:v]setdar=9/16,scale=356:640:force_original_aspect_ratio=decrease,pad=356:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,trim=duration=5,setpts=PTS-STARTPTS[v2];
[3:v]setdar=9/16,scale=356:640:force_original_aspect_ratio=decrease,pad=356:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,trim=duration=5,setpts=PTS-STARTPTS[v3];
[4:v]setdar=9/16,scale=356:640:force_original_aspect_ratio=decrease,pad=356:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,trim=duration=5,setpts=PTS-STARTPTS[v4];
[5:v]setdar=9/16,scale=356:640:force_original_aspect_ratio=decrease,pad=356:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=rgba,fps=fps=30,settb=expr=1/30,trim=duration=3.3,setpts=PTS-STARTPTS[v5];
color=black:s=720x1280:d=5:r=30,format=rgba,settb=expr=1/30[bg];
[bg][v0]overlay=x=0:y=0:shortest=0[o0];
[o0][v1]overlay=x=364:y=0:shortest=0[o1];
[o1][v2]overlay=x=0:y=640:shortest=0[o2];
[o2][v3]overlay=x=364:y=640:shortest=0[o3];
[o3][v4]overlay=x=0:y=640:enable='gte(t,0)':shortest=0[o4];
[o4][v5]overlay=x=364:y=640:shortest=0[o5];
[o5]split[v_main][v_overlay];
[v_main]settb=expr=1/30[v_concat];
[v_overlay]nullsink;
aevalsrc=0:d=2.88[s0];[s0]adelay=delays=0|0,volume=1[a0];
aevalsrc=0:d=5[s1];[s1]adelay=delays=2880|2880,volume=1[a1];
aevalsrc=0:d=5[s2];[s2]adelay=delays=7880|7880,volume=1[a2];
aevalsrc=0:d=5[s3];[s3]adelay=delays=12879.999999999998|12879.999999999998,volume=1[a3];
aevalsrc=0:d=5[s4];[s4]adelay=delays=17880|17880,volume=1[a4];
aevalsrc=0:d=3.3[s5];[s5]adelay=delays=22880|22880,volume=1[a5];
[a0][a1][a2][a3][a4][a5]amix=inputs=6:duration=longest[a_concat]
" \
-movflags +faststart \
-map "[v_concat]" \
-map "[a_concat]" \
-r 30 \
-ss 00:00:00 \
-to 00:00:19 \
-y "$OUTPUT_PATH"
