#!/usr/bin/env bash
set -euo pipefail

ffmpeg \
  -loop 1 -framerate 30 -i "$MEDIA_1" \
  -loop 1 -framerate 30 -i "$MEDIA_2" \
  -loop 1 -framerate 30 -i "$MEDIA_3" \
  -loop 1 -framerate 30 -i "$MEDIA_4" \
  -loop 1 -framerate 30 -i "$MEDIA_5" \
  -loop 1 -framerate 30 -i "$MEDIA_6" \
  -filter_complex "
[0:v]scale=240:640:force_original_aspect_ratio=decrease,pad=240:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=yuv420p,fps=30,settb=expr=1/30[v0];
[1:v]scale=240:640:force_original_aspect_ratio=decrease,pad=240:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=yuv420p,fps=30,settb=expr=1/30[v1];
[2:v]scale=240:640:force_original_aspect_ratio=decrease,pad=240:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=yuv420p,fps=30,settb=expr=1/30[v2];
[3:v]scale=240:640:force_original_aspect_ratio=decrease,pad=240:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=yuv420p,fps=30,settb=expr=1/30[v3];
[4:v]scale=240:640:force_original_aspect_ratio=decrease,pad=240:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=yuv420p,fps=30,settb=expr=1/30[v4];
[5:v]scale=240:640:force_original_aspect_ratio=decrease,pad=240:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,format=yuv420p,fps=30,settb=expr=1/30[v5];
[v0][v1][v2][v3][v4][v5]xstack=inputs=6:layout=0_0|240_0|480_0|0_640|240_640|480_640:fill=black,settb=expr=1/30,format=yuv420p[v_concat];
aevalsrc=0|0:s=48000:d=19[a_concat]
" \
  -map "[v_concat]" \
  -map "[a_concat]" \
  -c:v libx264 \
  -preset veryfast \
  -crf 25 \
  -pix_fmt yuv420p \
  -c:a aac \
  -b:a 128k \
  -movflags +faststart \
  -r 30 \
  -ss 00:00:00 \
  -to 00:00:19 \
  -y "$OUTPUT_PATH"
