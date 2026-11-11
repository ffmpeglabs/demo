ffmpeg \
-i "$MEDIA_1" \
-i "$MEDIA_2" \
-i "$MEDIA_3" \
-i "$MEDIA_4" \
-i "$MEDIA_5" \
-i "$MEDIA_6" \
-crf 25 \
-preset veryfast \
-filter_complex "\
[0:v]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=expr=1/30,format=yuv420p[v0];\
[1:v]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=expr=1/30,format=yuv420p[v1];\
[2:v]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=expr=1/30,format=yuv420p[v2];\
[3:v]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=expr=1/30,format=yuv420p[v3];\
[4:v]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=expr=1/30,format=yuv420p[v4];\
[5:v]scale=360:640:force_original_aspect_ratio=decrease,pad=360:640:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,settb=expr=1/30,format=yuv420p[v5];\
[v0][v1][v2][v3][v4][v5]xstack=inputs=6:layout=0_0|w0_0|w0+w1_0|0_h0|w0_h0|w0+w1_h0:fill=black,settb=expr=1/30,format=yuv420p[v_grid];\
[v_grid]nullsink" \
-map "[v_grid]" \
-r 30 \
-ss 00:00:00 \
-to 00:00:19 \
-movflags +faststart \
-y "$OUTPUT_PATH"
