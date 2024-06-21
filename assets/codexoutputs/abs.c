/* dune exec frama-c -- -codex -machdep x86_32 abs.c -codex-html-dump output.html -codex-type-file test.types -codex-overflow-alarms -main abs && cat test.dump */
/* dune exec frama-c -- -codex -machdep x86_32 -codex-print -codex-no-print-value -ulevel -1 abs.c -main abs -codex-exp-dump test.dump -codex-html-dump output.html -codex-type-file test.types -codex-overflow-alarms  */
int abs(int x){
  int res;
  if(x < 0)
    res = -x;
  else
    res = x;
  return res;
}
